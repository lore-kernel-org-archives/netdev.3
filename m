Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5914078CE
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787165222; cv=none; b=PRGxpYzcKAMaNPk81qImc0CCKuuhcIHSdRSG/P07bdcV/MWLT8LExlIEaQiS08nvILzvLrALtjf74sl/XVuUsdcfE4kerVcfrJtbJh4Ia/u9f2wci0HAxDzNzI6kA3yvm+zU0L+NdbbUTXUdgVK9y4LNsxxX/LoStlTq3Jx9i5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787165222; c=relaxed/simple;
	bh=cHHk5r/yhaOPVOxKjHfX8L5GuIhvEJHcNcPECsOGNJw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=opm9d7uNc00a1e7rKX6kYlXX1dLwIsN+nq45Y9ZCvAhm934uT254VjgP1PlVpOEY6zw5yc+xSY2DiXjDYKlfWZXeCMdBu3g35yQmFm9QG3QR8GHmIp+NFXsrsGmbo3rFvOyiiKOyESihRYxxctTVlFsk6RCgoL+lWNYrFTSkHPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP1BdBEi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP1BdBEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB4F1F00A3D
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 18:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787165220;
	bh=3dyQV3tEJTaiMTq/pMT60dL0w+DK+PFG3DPCg+8P2F0=;
	h=Date:From:To:Subject;
	b=eP1BdBEiMVDxpGVzd7F954BoEqbGLtj7qxsLRnG0MAlRfMNyntbymG2mDmPcsa91J
	 /YNYdaiod6oif7ACuVeRcOz0+adPAOHdxp3NJj98EMr1IlR/SjUaw4Sd/jm70P7+ac
	 WsVHUEwYx4HDxuRHtpzrxEiIBQBmLVB8f2e0bapqplc64LVNj02TTk2onXKR4KdLsV
	 pGVmSou8OfjqRLVtu1nHL+d+FdqRRn9H1epseeAnVSHwbDhhwM5Fn2brdYdq80FDxE
	 SL/cj96godmg6PLjkUiG3flJLMqv+VUtGz2SP1Q5vbLI5l2q1gffqoe7Oz/69Cotiu
	 9i/5TdrdG5trw==
Date: Wed, 19 Aug 2026 11:46:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev development stats for 7.3
Message-ID: <20260819114659.271292db@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Preface
-------

As is tradition here are the development statistics based on mailing
list traffic on netdev@vger.

These stats are somewhat like LWN stats: https://lwn.net/Articles/1088776/
but more focused on mailing list participation. In particular "review
score" tries to capture the balance between reviewing other people's
code vs posting patches.

Previous 3 reports:
 - for 7.0:  https://lore.kernel.org/20260212124208.187e53ae@kernel.org
 - for 7.1:  https://lore.kernel.org/20260414182653.40d84ccc@kernel.org
 - for 7.2   https://lore.kernel.org/20260617115319.43a5942d@kernel.org

General stats
-------------

7.3 release cycle spanned summer vacation season and netdev.conf.
The direct comparisons to the previous release are a little misleading.=20

The number of commits by maintainers dropped by 24%. back to 22
commits/day. Which used to be the usual rate before AI.
Messages to the list dropped only by 7%, so less than the drop in
commits. We were far less efficient at accepting code. Everyone has
probably experienced the huge patch backlog so this is no surprise.

Patch review has recovered to 64% in total and 54% across company
(up 14% in both cases). Best result in a while. I think it's partially
due to our use of the SUIE ranking (see the netdev.conf talk by Paolo).
Since we now always have >300 patches awaiting review looking thru
one's inbox or even patchwork is impractical. SUIE shows all patchwork
data, sorted by a combination of "readiness" and "author's reviewer
score". The readiness means CI signals + did anyone review the patch
already. This means that maintainers apply reviewed patches first -
potentially having a positive effect on overall review ratio.

The only volume metric which did not go down in this release was growth
in the number of individuals that emailed the list. We have seen 4.5%
more people in this release cycle. Of course, these are mostly LLM-aided
"pure authors" who never comment on other peoples posting.

Posting efficiency
------------------

Given the overall drop in our efficiency in converting postings into
commits I decided to dig a little deeper into that side of the data.
First, I fixed how we count "revisions" in the scripts - they used to
only count postings, so if versioning started before the release cycle
we'd miss-count (e.g. if v22 was merged, but script only saw postings
from v19 on - we'd count it as the fourth revision). With that fix, our
"average revisions" numbers are at 1.7 for a single patch and a round
3.0 for a patch series.

Here is the ranking of people who need fewest and most patch postings
for a commit to appear in the tree:

Lowest postings/commit (min 5):      Highest postings/commit (min 2 commits=
):   =20
   1 [13@ 1.00] Ciprian Regus           1 [ 3@39.67] Christian Marangi (Ans=
uel)
 --2-[56@ 1.00]-Florian Westphal        2 [ 5@19.20] javen              =20
   3 [ 7@ 1.00] Ido Schimmel            3 [ 8@14.38] Th=C3=A9o Lebrun      =
  =20
   4 [ 8@ 1.00] Krzysztof Kozlowski     4 [ 3@14.00] Chuck Lever        =20
 --5-[39@ 1.00]-Marc Kleine-Budde       5 [ 2@12.00] Jakub Sitnicki     =20
 --6-[24@ 1.04]-Steffen Klassert        6 [ 2@11.50] Pengpeng Hou       =20
   7 [15@ 1.07] Ioana Ciornei           7 [ 4@11.25] Willem de Bruijn   =20
   8 [13@ 1.08] Arnd Bergmann           8 [ 5@10.80] Xin Xie            =20
   9 [12@ 1.08] Ilya Maximets           9 [ 4@10.25] Muhammad Nazim Amirul
  10 [15@ 1.13] Mohsin Bashir          10 [ 6@ 9.00] Mahe Tardy         =20
 -11-[20@ 1.20]-Antonio Quartulli      11 [12@ 8.83] Ratheesh Kannoth   =20
  12 [ 5@ 1.20] Avi Weiss              12 [ 6@ 8.50] Michael Chan       =20
  13 [ 5@ 1.20] Dawei Feng             13 [11@ 8.36] Daniel Golle       =20
  14 [ 8@ 1.25] Joe Damato             14 [ 2@ 8.00] Yehyeong Lee       =20
 -15-[55@ 1.27]-Simon Wunderlich       15 [ 2@ 8.00] Weimin Xiong       =20
       ^     ^
 number of   postings per
  commits    1 commit

I marked with "-" our co-maintainers, who send us already reviewed patches
/ PRs. These are of course more likely to be accepted on the first attempt.
And here is similar breakdown for companies (well, plus people who's
employer we don't know):

Lowest postings/commit (min 10):     Highest postings/commit (min 5):   =20
   1 [ 14@ 1.00] Analog Devices         1 [ 5@19.20] Realsil            =20
   2 [ 41@ 1.15] Pengutronix            2 [ 5@10.80] Xin Xie            =20
   3 [ 20@ 1.20] (OpenVPN)              3 [11@ 8.36] Daniel Golle       =20
   4 [ 55@ 1.27] (batman-adv)           4 [16@ 8.19] Microsoft          =20
   5 [ 91@ 1.34] (netfilter)            5 [14@ 7.64] SUSE               =20
   6 [ 38@ 1.39] (mptcp)                6 [13@ 7.00] Broadcom           =20
   7 [ 24@ 1.46] (xfrm)                 7 [10@ 6.80] Alvin Sun          =20
   8 [ 28@ 1.50] Linaro                 8 [24@ 5.83] Marvell            =20
   9 [ 30@ 1.83] Arizona State          9 [ 8@ 5.62] Weiming Shi        =20
  10 [ 26@ 2.04] Gary Guo              10 [40@ 5.25] Bootlin            =20
  11 [ 12@ 2.33] Mojatatu              11 [28@ 5.18] IBM                =20
  12 [155@ 2.38] Meta                  12 [10@ 5.10] Trustnetic         =20
  13 [ 25@ 2.48] Tsinghua University   13 [16@ 5.00] Oracle             =20
  14 [112@ 2.63] RedHat                14 [12@ 5.00] Code Construct     =20
  15 [107@ 2.75] nVidia                15 [51@ 4.88] Qualcomm           =20

I'm curious what sets the two sides of the comparison aside. I could
venture two guesses.=20

One - smaller patch sets are easier to merge. nVidia/Tariq is putting
in the effort to break the submissions up which is probably part of
the reason why they only need 2.75 revision vs (eg.) Broadcom's 7.
With AI reviewers semi-randomly flagging issues the chances of a "clean"=20
15 patch submission are pretty much zero.

Two - I suspect companies like nVidia (2.75 avg rev) and Meta (2.38 revs)=20
do much more in-house AI review of their code than Broadcom (7 revs),
Marvell (5.83 revs), or Qualcomm (4.88 revs).

So tl;dr - break up your patch sets, run AI reviews locally first.

Here (for no good reason) is a list of people / companies who made
the most posts without getting a _single one_ of them merged:

Nothing merged, people (min 30):     Nothing merged, companies (min 30):=20
   1 (***) [ 106] Louis-Alexis Eyraud   1 (***) [ 106] Collabora        =20
   2 (***) [  86] Birger Koblitz        2 (***) [  86] Birger Koblitz   =20
   3 (***) [  83] Mingming Cao          3 (***) [  68] Nebula Matrix    =20
   4 (***) [  75] Long Li               4 (***) [  64] James Hilliard   =20
   5 (***) [  68] Illusion Wang         5 (***) [  53] Luke Howard      =20
   6 (***) [  64] James Hilliard        6 (***) [  48] Onsemi           =20
   7 (***) [  53] Luke Howard           7 (***) [  44] Jonas Jelonek    =20
   8 (***) [  48] Selvamani Rajagopal   8 (***) [  40] SK Hynix         =20
   9 (***) [  44] Jonas Jelonek         9 (***) [  32] Akari Tsuyukusa  =20
  10 (***) [  40] Byungchul Park       10 (***) [  32] Rong Zhang       =20
  11 (***) [  32] Akari Tsuyukusa                                       =20
  12 (***) [  32] Rong Zhang                                            =20
  13 (***) [  30] Amery Hung                                            =20

Testing and CI
--------------

Customary top ranking of selftest contributors:

Contributions to selftests:
   1 [ 15] Mohsin Bashir
   2 [ 11] Jakub Kicinski
   3 [ 10] Matthieu Baerts
   4 [  8] Joe Damato
   5 [  6] Marcelo Mendes Spessoto Junior
   6 [  3] Minxi Hou
   7 [  3] Breno Leitao
   8 [  3] Willem de Bruijn
   9 [  3] Bobby Eshleman
  10 [  3] Maciej Fijalkowski
  11 [  3] Nirmoy Das
  12 [  3] Tushar Vyavahare

The main infra side changes were around HW testing. The NICs we have in NIPA
and the results reported by external runners are reaching stability.=20
Hopefully we'll be soon reporting the HW test results to patchwork.

Smaller changes:
 - wireless tree is now using netdev foundation machines
 - UI color highlight for TAP results
 - lots of stability / error handling fixes all over the place
   as all external services we talk to are periodically overloaded
   by AI bots

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):               =20
   1 (   ) [46] Jakub Kicinski          1 (   ) [90] Jakub Kicinski     =20
   2 (   ) [28] Simon Horman            2 (   ) [59] Andrew Lunn        =20
   3 (   ) [21] Andrew Lunn             3 (   ) [43] Simon Horman       =20
   4 (   ) [17] Paolo Abeni             4 (   ) [27] Paolo Abeni        =20
   5 ( +1) [ 8] Ido Schimmel            5 ( +1) [15] Ido Schimmel       =20
   6 ( +7) [ 7] Maxime Chevallier       6 ( +7) [15] Maxime Chevallier  =20
   7 ( +2) [ 6] Kuniyuki Iwashima       7 ( +3) [12] Kuniyuki Iwashima  =20
   8 ( -3) [ 6] Eric Dumazet            8 ( +8) [10] Krzysztof Kozlowski=20
   9 ( +1) [ 5] Aleksandr Loktionov     9 ( +3) [10] Willem de Bruijn   =20
  10 (+12) [ 5] Vadim Fedorenko        10 (+30) [10] Vadim Fedorenko    =20
  11 (+16) [ 5] Breno Leitao           11 ( -3) [ 8] Aleksandr Loktionov=20
  12 ( +3) [ 4] Willem de Bruijn       12 ( -7) [ 8] Eric Dumazet       =20
  13 ( -1) [ 4] Krzysztof Kozlowski    13 (+31) [ 8] Breno Leitao       =20
  14 (***) [ 4] Xin Long               14 ( -3) [ 7] Stanislav Fomichev =20
  15 ( +5) [ 3] Stanislav Fomichev     15 ( +4) [ 6] Michael S. Tsirkin =20
  16 (***) [ 3] Tung Nguyen

Ido has been handling a lot of AI-generated fixes, primarily to the IP
layer but not only. Similarly Willem has been handling AI fixes for
AF_PACKET, tap, UDP etc. Xin Long is quite busy reviewing
all the SCTP fixes. Tung Nguyen handles all TIPC fixes.

Maxime has stepped up further in phylink reviews and has taken on stmmac
reviews, which is the busiest driver, and certainly one which has the
most contributors.

We would have completely fallen apart without these people so huge
thanks!

Top authors (cs):                    Top authors (msg):                 =20
   1 (   ) [5] Eric Dumazet             1 (+23) [18] Tony Nguyen        =20
   2 (***) [5] Xiang Mei (Microsoft)    2 (   ) [17] Tariq Toukan       =20
   3 ( -1) [4] Jakub Kicinski           3 ( +2) [15] Pablo Neira Ayuso  =20
   4 (***) [4] Ren Wei                  4 (***) [14] Christian Marangi (Ans=
uel)
   5 ( -2) [4] Tariq Toukan             5 ( +3) [14] Ratheesh Kannoth   =20
   6 (***) [3] Lorenzo Bianconi         6 (***) [14] Th=C3=A9o Lebrun      =
  =20
   7 (***) [3] Xuanqiang Luo            7 (+12) [13] Markus Stockhausen =20
   8 (***) [2] David Lee                8 ( -1) [13] Kuniyuki Iwashima  =20
   9 (***) [2] Doruk Tan Ozturk         9 (***) [12] Louis-Alexis Eyraud=20
  10 (***) [2] Pengpeng Hou            10 (   ) [12] javen              =20
  11 (***) [2] Zhiling Zou             11 (+47) [12] David Howells      =20
  12 ( +4) [2] Yizhou Zhao             12 (+14) [12] Daniel Golle       =20
  13 (+49) [2] Ratheesh Kannoth        13 ( -9) [12] Wei Fang           =20
  14 ( -8) [2] Weiming Shi             14 (***) [11] Lorenzo Bianconi   =20
  15 (+23) [2] Runyu Xiao              15 (-14) [11] Eric Dumazet       =20

Eyeballing the left - "top author (change sets)" side - 10 of the names
belong to AI fixers. On the right side we have the vendor maintainers at
the top, and a large number of embedded folks who like to keep re-submitting
giant series.

Top scores (positive):               Top scores (negative):             =20
   1 (   ) [684] Jakub Kicinski         1 (+26) [62] Tony Nguyen        =20
   2 (   ) [390] Simon Horman           2 (+47) [55] Christian Marangi (Ans=
uel)
   3 (   ) [380] Andrew Lunn            3 ( +8) [52] Markus Stockhausen =20
   4 (   ) [239] Paolo Abeni            4 ( -3) [51] Tariq Toukan       =20
   5 (   ) [126] Ido Schimmel           5 (***) [50] Louis-Alexis Eyraud=20
   6 ( +7) [ 91] Maxime Chevallier      6 ( -2) [50] javen              =20
   7 (+18) [ 80] Vadim Fedorenko        7 ( -4) [50] Ratheesh Kannoth   =20
   8 (   ) [ 70] Aleksandr Loktionov    8 (***) [48] David Howells      =20
   9 ( -2) [ 64] Krzysztof Kozlowski    9 (+17) [48] Daniel Golle       =20
  10 (+21) [ 51] Tung Nguyen           10 ( -8) [44] Wei Fang           =20
  11 ( -1) [ 47] Willem de Bruijn      11 (***) [43] Th=C3=A9o Lebrun      =
  =20
  12 (+45) [ 43] Kuniyuki Iwashima     12 (***) [42] Birger Koblitz     =20
  13 ( +4) [ 43] Michael S. Tsirkin    13 (***) [40] Mingming Cao       =20
  14 (***) [ 38] Xin Long              14 (***) [39] Ren Wei            =20
  15 ( +4) [ 37] Sasha Levin           15 (+26) [36] Long Li               =
 =20

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):               =20
   1 (   ) [58] Meta                    1 (   ) [125] Meta              =20
   2 (   ) [57] RedHat                  2 (   ) [108] RedHat            =20
   3 (   ) [21] Andrew Lunn             3 (   ) [ 59] Andrew Lunn       =20
   4 (   ) [19] Intel                   4 (   ) [ 40] Intel             =20
   5 (   ) [18] Google                  5 (   ) [ 39] Google            =20
   6 (   ) [15] nVidia                  6 (   ) [ 31] nVidia            =20
   7 ( +1) [ 9] Bootlin                 7 ( +3) [ 18] Bootlin           =20
   8 ( +1) [ 6] Linaro                  8 ( +1) [ 16] Linaro            =20
   9 (+14) [ 5] Qualcomm                9 (+12) [ 11] Qualcomm          =20

Top authors (cs):                    Top authors (msg):                 =20
   1 (   ) [12] Google                  1 ( +1) [52] Google             =20
   2 (   ) [10] Meta                    2 ( -1) [46] Meta               =20
   3 (***) [ 7] Nebula Sec              3 (   ) [43] Intel              =20
   4 (+11) [ 7] Kylin Software          4 ( +1) [39] nVidia             =20
   5 (   ) [ 7] nVidia                  5 ( -1) [37] RedHat             =20
   6 ( -2) [ 6] Intel                   6 ( +2) [31] Qualcomm           =20
   7 ( -4) [ 5] RedHat                  7 ( +8) [26] Bootlin            =20
   8 (+33) [ 5] Arizona State           8 ( +6) [20] AMD                =20
   9 (+16) [ 5] Tsinghua University     9 (   ) [19] Microsoft          =20

Top scores (positive):               Top scores (negative):             =20
   1 ( +1) [768] Meta                   1 (***) [72] Nebula Sec         =20
   2 ( -1) [734] RedHat                 2 ( +5) [70] AMD                =20
   3 (   ) [380] Andrew Lunn            3 ( -1) [59] Marvell            =20
   4 ( +8) [124] Intel                  4 (+30) [55] Christian Marangi (Ans=
uel)
   5 (   ) [100] nVidia                 5 ( +8) [52] Markus Stockhausen =20
   6 (+10) [ 88] Google                 6 ( -2) [50] Realsil            =20
   7 (   ) [ 79] Linaro                 7 (***) [49] Collabora          =20
   8 (***) [ 63] Stable team            8 (+13) [48] Daniel Golle       =20
   9 ( +6) [ 51] Tung Nguyen            9 ( -1) [46] Microsoft          =20

AI reviews
----------

Last time I was complaining that we lack access to frontier models.
This has been fixed a couple of weeks ago. We have Opus 5 + GPT 5.6
integrated into our instance of Sashiko. The switch from Opus 4.7 to Opus 5
led to a major increase in accuracy and number of reported problems. It als=
o,
unfortunately, doubled the cost of the reviews. Luckily Meta is still willi=
ng
to foot the bill. Special shout out to Chris Mason for the help getting us
the GPT access.

With the cross reviews in place I'm really hoping we'll have enough confide=
nce
in the reviews to send them out to the list automatically.
--=20
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/ml-stats/stats-7.3
