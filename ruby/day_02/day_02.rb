MATCH_SCORE = 
  {
    win: 6,
    draw: 3,
    lose: 0
  }

SIGN_SCORE =
  {
    rock: 1,
    paper: 2,
    scissor: 3
  }

OPPONENT =
  {
    'A' => :rock,
    'B' => :paper,
    'C' => :scissor
  }

ME = 
  {
    'X' => :rock,
    'Y' => :paper,
    'Z' => :scissor
  }

MATCH = 
  [
    [:rock, :rock, :draw],
    [:rock, :paper, :win],
    [:rock, :scissor, :lose],
    [:paper, :rock, :lose],
    [:paper, :paper, :draw],
    [:paper, :scissor, :win],
    [:scissor, :rock, :win],
    [:scissor, :paper, :lose],
    [:scissor, :scissor, :draw]
  ]


MY_RESULT = 
{
  'X' => :lose,
  'Y' => :draw,
  'Z' => :win
}

class MatchBySign
  def initialize(opponent, me)
    @opponent = OPPONENT[opponent]
    @me = ME[me]
  end

  def result
    @result ||= 
      MATCH.select do |m|
        m[0] == @opponent && m[1] == @me
      end.first[2]
  end

  def my_score
    MATCH_SCORE[result] + SIGN_SCORE[@me]
  end
end

class MatchByResult
  def initialize(opponent, result)
    @opponent = OPPONENT[opponent]
    @result = MY_RESULT[result]
  end

  def me
    @me ||= 
      MATCH.select do |m|
        m[0] == @opponent && m[2] == @result
      end.first[1]
  end

  def my_score
    MATCH_SCORE[@result] + SIGN_SCORE[me]
  end
end

input = File.readlines('./input').map(&:strip)
matches = 
  input.map do |line|
    opponent, me = line.split(' ')
    MatchBySign.new(opponent, me)
  end

puzzle_1 = 
  matches.sum do |m|
    m.my_score
  end

puts "puzzle_1: #{puzzle_1}"

matches = 
  input.map do |line|
    opponent, result = line.split(' ')
    MatchByResult.new(opponent, result)
  end

puzzle_2 = 
  matches.sum do |m|
    m.my_score
  end

puts "puzzle_2: #{puzzle_2}"