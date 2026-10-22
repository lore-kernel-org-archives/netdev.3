Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702645;
	b=Ue8shI0m19r4/R0f4qqvuVZWs3P0albrkjbC3m/IMh3D3b7ua+TTmQUCqfsar39oLTtz
	 pS5Dr1EyFgQseWNcdewr4aZDMAYxZNp9Y/TEAyqsXtVW98BvMuLJ7qivqLicDbBn6iiQa
	 D6cGCVqukUuArGbSFctBf8pmAvN/zrS67QEW1miHx8h+dSDBSClcvt4J1Br3GOUx5b+qI
	 eZhN1PqhNI0TWdcEG9WkcJPvM80rHBlt/SnyPlSkcTHT4aU3W57bscd+FbMXhp+DnX501
	 Li9zqkprpadkQ6azd5x6H6LayOf2vnInPC7IBYEP6Bo1Pt0rhs533f19CVY2drpQrqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702645;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=HsEkyphgvhGbI/L+Hy4M0mCBmILVmkRHOwkYevEv6os=;
	b=jhUZCEez6nTwh6eVFqBlYuNjnaOtteAJGS3Y/plEdxuCiJ/Yf1g3Dky+umxvbVHK6+01
	 Tuyzs3RAuJCZVH6rtRYivSyuU6dGW1R3h+6BdwtXXz6+Ch9+4yLFk9Dnrl+Ru2dcLSTA/
	 uMrw0lZLjha4X4onBdyF4VSH4dRLH2JWKyVGwmbHH6N9geqIyll+jSYe/trF+ZxeD/fXM
	 1NCvvcO428eJgeKuCj9zTAT+DeKI2a8mjhULL8faypuQ0JSogQqDNn7mP+TDUPx5R8A0C
	 dzZdGfzgkqHTQ0UiOPsZkvypa1oTU2epON+VPp76TnKxmYxhESwBkyEpjPBUBCBwU3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGRt5yAh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D7606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGRt5yAh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E071F01825
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792702644;
	bh=HsEkyphgvhGbI/L+Hy4M0mCBmILVmkRHOwkYevEv6os=;
	h=Date:From:To:Subject;
	b=aGRt5yAhVie4vQGAimselzP3qqyr89sIJV8uPUoh321mbsYmnpawms8ZVU0r1qHRS
	 atM1/u2kj0fBcnUNtbLOAVvgVTfdHT+IQ7c+sc1Rv3gFQcxk5Pths5xQFGdLBgR4WZ
	 daOGu9pGeT9Nf1nzbReQQLnC1bF89lpkcQtaflzd1TlE/QOD/y9tekT6we26L9uteF
	 hOZK5iX1KG9V5ugUTu7GTm0TVx5z9PoqA9xKpvmpC+lIpUFxdqP+u6Nu027plob0jF
	 +456QB6D7y+Go3F9Mgr0yoNI2vLGsZgMsVbUrc0r3YeE3sM4rKCMn4XF1CgKkEJhZM
	 3CSGqaq/2Vmpw==
Date: Thu, 22 Oct 2026 13:57:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev development stats for 7.4
Message-ID: <20261022135723.07412855@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
 - for 7.1:  https://lore.kernel.org/20260414182653.40d84ccc@kernel.org
 - for 7.2:  https://lore.kernel.org/20260617115319.43a5942d@kernel.org
 - for 7.3:  https://lore.kernel.org/20260819114659.271292db@kernel.org

Highlights
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Not sure how many people read these, but I expect more than any other
email on the list, so let me start with some highlights / announcements.

SUIE
----

SUIE, which maintainers use to order review queue, now supports
filtering by MAINTAINERS entries. If you find it difficult to sift=20
thru the list of patches please try it. Click the funnel icon, select
the subsystems, and enable the filter.

https://netdev.bots.linux.dev/suie.html?delegate=3Dnetdev

Clashiko
--------

Major change in this cycle is that we started emailing out the AI
reviews automatically. This obviously has negative implications
(extra work for submitters, risk of going down the wrong path,
higher ML volume as people respin for AI feedback).

With the growth of patch volume it was unavoidable. Not sure how
to explain this but I was basically 30min to an hour short of time
in a 24h day, and it was getting worse and worse. Not having to handle
the AI reports saves me at least an hour a day. We'll see what other
compromises we have to make if the volume continues to grow :(

=46rom the technical side the AI reviews got reshuffled to support
multiple models. We test with GPT and Opus, and leech off main
sashiko to get Gemini reviews. This brought the false positive rate
(as measured by patches applied with Medium+ severity feedback) is
around 20%. The false negative (patches rejected without feedback)=20
is around 10%.

At least some of the 20% false positives are real problems, we don't
design locking and reset handling properly. Pure hallucinations are
infrequent.

Stats
=3D=3D=3D=3D=3D

General
-------

The previous (7.3) release cycle spanned summer vacation season and
netdev.conf, so let's compare against last two releases.=20

We merged 43% more patches than in 7.3,  9% more than in 7.2.
We saw 48% more emails than during 7.3, 37% more than in 7.2.
There were 12% more participants on the list, 17% compared to 7.2.
Lines goes up.

Clashiko and series info bot were directly responsible for 13% of=20
the traffic, so traffic not counting the bots went up 35% (vs 7.3)=20
and 24% (vs 7.2). Hard to tell how much of the increase was indirectly
attributable to bots as people repost to fix AI reviews.

Almost half of the patches are fixing bugs. Of the patches posted
it's 39% and of the patches merged 46%. I think this reflects the
developer experience of development of new features being harder=20
and slower these days.

Number of necessary revisions went up for a single patch: +5.4%
and patch set: +1.6%. Cross company review recovered 4% to 58%
of commits carrying a review tag.

Developer rankings
------------------

Top reviewers (cs):                  Top reviewers (msg):               =20
   1 (   ) [49] Jakub Kicinski          1 (   ) [91] Jakub Kicinski     =20
   2 (   ) [28] Simon Horman            2 (   ) [70] Andrew Lunn        =20
   3 (   ) [25] Andrew Lunn             3 (   ) [42] Simon Horman       =20
   4 (   ) [19] Paolo Abeni             4 (   ) [27] Eric Dumazet       =20
   5 (   ) [17] Eric Dumazet            5 ( -1) [26] Paolo Abeni        =20
   6 ( -1) [11] Ido Schimmel            6 ( -1) [19] Ido Schimmel       =20
   7 ( -1) [ 7] Maxime Chevallier       7 ( +2) [17] Willem de Bruijn   =20
   8 ( +1) [ 7] Aleksandr Loktionov     8 ( -2) [15] Maxime Chevallier  =20
   9 (+34) [ 6] Hangbin Liu             9 (+18) [13] Nicolai Buchwitz   =20
  10 ( +2) [ 6] Willem de Bruijn       10 ( +1) [12] Aleksandr Loktionov=20
  11 ( -4) [ 5] Kuniyuki Iwashima      11 ( -4) [11] Kuniyuki Iwashima  =20
  12 (+37) [ 5] Nicolai Buchwitz       12 (+44) [10] Hangbin Liu        =20
  13 (   ) [ 5] Krzysztof Kozlowski    13 ( +1) [ 9] Stanislav Fomichev =20
  14 (+23) [ 4] David Laight           14 ( +6) [ 8] Lorenzo Bianconi   =20
  15 (***) [ 4] Daniel Machon          15 ( -7) [ 8] Krzysztof Kozlowski=20

Ido continues to handle the influx of fixes for L3,=20
Maxime is now officially a maintainer of stmmac (and helps with phylink).
Willem concentrates on virtio / tap / af_packet etc.
Hangbin reviews selftests, bonding, seg6, netlink etc.
Nicolai reviews embedded drivers (stmmac, macb, bcm* etc)
Thanks as always to everyone reviewing!

Top authors (cs):                    Top authors (msg):                 =20
   1 (***) [9] Eric Dumazet             1 (***) [30] Eric Dumazet       =20
   2 (***) [5] Hui Peng                 2 ( +6) [22] Kuniyuki Iwashima  =20
   3 (+22) [5] Wentao Liang             3 (+13) [20] Birger Koblitz     =20
   4 ( -1) [5] Jakub Kicinski           4 (***) [19] Allison Henderson  =20
   5 (+23) [4] Chengfeng Ye             5 (***) [19] Aleksei Sviridkin  =20
   6 (+24) [4] Jamal Hadi Salim         6 ( -4) [19] Tariq Toukan       =20
   7 ( -2) [4] Tariq Toukan             7 ( -4) [18] Pablo Neira Ayuso  =20
   8 ( -2) [4] Lorenzo Bianconi         8 (***) [18] Marc Kleine-Budde  =20
   9 ( +4) [4] Ratheesh Kannoth         9 (+12) [16] Jakub Kicinski     =20
  10 ( -6) [3] Ren Wei                 10 (+12) [15] James Hilliard     =20
  11 (+12) [3] Zihan Xi                11 (-10) [15] Tony Nguyen        =20
  12 (***) [3] Aamir Ahmed             12 (+23) [15] Maxime Chevallier  =20
  13 (+23) [3] Myeonghun Pak           13 ( +1) [14] Lorenzo Bianconi   =20
  14 ( +7) [3] Rosen Penev             14 (-10) [14] Christian Marangi (Ans=
uel)
  15 (***) [3] Daehyeon Ko             15 (***) [14] Zihan Xi           =20

Folks who read the mailing list will note that roughly half
of the top authors by change set are LLM-aided newcomers.
The different between count of change set (left) and messages (right)
is striking, almost everyone on the right side is a long time
contributor. This suggests that the noobs send a ton of patches
and never follow up with new versions.

Top scores (positive):               Top scores (negative):             =20
   1 (   ) [691] Jakub Kicinski         1 (+11) [77] Birger Koblitz     =20
   2 ( +1) [454] Andrew Lunn            2 (***) [74] Aleksei Sviridkin  =20
   3 ( -1) [382] Simon Horman           3 (+37) [64] Marc Kleine-Budde  =20
   4 (   ) [254] Paolo Abeni            4 (+12) [57] James Hilliard     =20
   5 (   ) [161] Ido Schimmel           5 (***) [57] Zihan Xi           =20
   6 (***) [124] Eric Dumazet           6 ( -2) [56] Tariq Toukan       =20
   7 ( +4) [ 90] Willem de Bruijn       7 (***) [54] Kyle Switch        =20
   8 (   ) [ 77] Aleksandr Loktionov    8 ( -7) [52] Tony Nguyen        =20
   9 (   ) [ 64] Krzysztof Kozlowski    9 ( -7) [52] Christian Marangi (Ans=
uel)
  10 ( -4) [ 63] Maxime Chevallier     10 (***) [52] Allison Henderson  =20
  11 (+18) [ 52] David Laight          11 (+37) [49] David Yang         =20
  12 (+21) [ 51] Nicolai Buchwitz      12 (***) [47] Coia Prant         =20
  13 (+36) [ 50] Hangbin Liu           13 (***) [45] Ali Rouhi          =20
  14 ( +6) [ 46] Stanislav Fomichev    14 (***) [34] Christian Brauner  =20
  15 (+11) [ 40] Stefano Garzarella    15 ( -2) [33] Mingming Cao       =20

Company rankings
----------------

Top reviewers (cs):                  Top reviewers (msg):               =20
   1 ( +1) [60] RedHat                  1 (   ) [120] Meta              =20
   2 ( -1) [58] Meta                    2 (   ) [106] RedHat            =20
   3 (   ) [25] Andrew Lunn             3 (   ) [ 70] Andrew Lunn       =20
   4 ( +2) [21] nVidia                  4 ( +2) [ 40] nVidia            =20
   5 (***) [17] Eric Dumazet            5 (   ) [ 38] Google            =20
   6 ( -1) [15] Google                  6 ( -2) [ 28] Intel             =20
   7 ( -3) [13] Intel                   7 (***) [ 27] Eric Dumazet      =20
   8 ( -1) [11] Bootlin                 8 ( -1) [ 22] Bootlin           =20
   9 (+21) [ 9] Kylin Software          9 (+26) [ 15] Kylin Software    =20
  10 ( -2) [ 7] Linaro                 10 ( -2) [ 14] Linaro               =
 =20

Top authors (cs):                    Top authors (msg):                 =20
   1 (   ) [13] Google                  1 (   ) [68] Google             =20
   2 (   ) [11] Meta                    2 (   ) [68] Meta               =20
   3 (***) [ 9] Eric Dumazet            3 (   ) [54] Intel              =20
   4 ( +1) [ 7] nVidia                  4 (   ) [42] nVidia             =20
   5 ( -2) [ 7] Nebula Sec              5 ( +1) [38] Qualcomm           =20
   6 ( +5) [ 6] Qualcomm                6 ( -1) [32] RedHat             =20
   7 (   ) [ 6] RedHat                  7 (***) [30] Eric Dumazet       =20
   8 ( +4) [ 6] Chinese Academy of Sciences    8 ( +1) [28] Microsoft      =
    =20
   9 (+14) [ 6] Mojatatu                9 (+17) [28] Oracle             =20
  10 ( -6) [ 6] Kylin Software         10 ( +1) [26] Nebula Sec          =20

Top scores (positive):               Top scores (negative):             =20
   1 ( +1) [761] RedHat                 1 (   ) [104] Nebula Sec        =20
   2 ( -1) [654] Meta                   2 (+10) [ 77] Birger Koblitz    =20
   3 (   ) [454] Andrew Lunn            3 (***) [ 75] Pengutronix       =20
   4 ( +1) [162] nVidia                 4 (***) [ 74] =C3=86nix            =
  =20
   5 (***) [124] Eric Dumazet           5 ( +4) [ 69] Microsoft         =20
   6 ( +4) [ 81] Bootlin                6 ( +5) [ 58] Qualcomm          =20
   7 (***) [ 56] Kylin Software         7 ( +6) [ 57] James Hilliard    =20
   8 ( +4) [ 52] Aculab                 8 (+37) [ 54] Oracle            =20
   9 ( +5) [ 51] KUNBUS                 9 (***) [ 54] Motorcomm         =20
  10 ( +1) [ 41] ARM                   10 ( -6) [ 52] Christian Marangi (An=
suel)

Major changes in the company rankings is that Eric Dumazet
no longer works at Google, dropping Google to a "negative score".

Nebula Sec is one of the LLM fix companies, they used to do pretty
well but recently the patches are lower quality, and don't end up
getting merged.

Kylin OTOH moved to the positive side by cutting down on the bad
submissions and thanks to Hangbin's review effort.

Posting efficiency
------------------

Here are the stats for people who are best / worst at getting
code into the tree. I think at some point we may need to include
these in the "SUIE score".

Lowest postings/commit (min 10):     Highest postings/commit (min 10):  =20
   1 [ 14@ 1.00] Ruizhe Zhou            1 [15@ 8.87] =C3=86nix             =
  =20
   2 [ 39@ 1.23] batman-adv             2 [26@ 8.54] Oracle             =20
   3 [ 34@ 1.26] TI                     3 [22@ 8.18] Pengutronix        =20
   4 [ 31@ 1.71] NGI0 Core              4 [53@ 7.98] Intel              =20
   5 [ 84@ 1.76] Pablo Neira Ayuso      5 [32@ 7.06] Microsoft          =20
   6 [ 10@ 2.00] Andrew Halaney         6 [21@ 6.48] Microchip          =20
   7 [ 15@ 2.00] Karl Mehltretter       7 [48@ 6.31] Qualcomm           =20
   8 [ 69@ 2.10] Mojatatu               8 [20@ 6.25] Linaro             =20
   9 [ 17@ 2.12] OpenVPN                9 [11@ 5.82] Renesas            =20
  10 [112@ 2.14] Eric Dumazet          10 [19@ 5.74] Marvell            =20
  11 [ 21@ 2.19] Hemanth Selam         11 [31@ 5.68] Broadcom           =20
  12 [ 55@ 2.25] Anthropic             12 [11@ 5.55] Daniel Golle       =20
  13 [ 19@ 2.26] Isovalent             13 [17@ 5.35] AMD                =20
  14 [212@ 2.44] Meta                  14 [52@ 5.02] RedHat             =20
  15 [ 23@ 2.48] Secunet               15 [26@ 4.88] Nebula Sec         =20
       ^     ^
 number of   postings per
  commits    1 commit

Nothing merged, people (min 30):     Nothing merged, companies (min 30):=20
   1 (***) [ 101] Kyle Switch           1 (***) [ 101] Motorcomm        =20
   2 (***) [  61] Chih Kai Hsu          2 (***) [  61] RealTek          =20
   3 (***) [  54] Juha-Matti Tilli      3 (***) [  54] Juha-Matti Tilli =20
   4 (***) [  42] Julius Bairaktaris    4 (***) [  42] Julius Bairaktaris
   5 (***) [  41] Jacob Keller          5 (***) [  35] Chelsio          =20
   6 (***) [  41] Mohd Ayaan Anwar      6 (***) [  32] Caleb James DeLisle
   7 (***) [  38] Wei Hu                7 (***) [  32] Junhui Liu       =20
   8 (***) [  36] Jens ES. Ostergaard                                    =20
   9 (***) [  36] Pooventhiran G                                        =20
  10 (***) [  35] Potnuri Bharat Teja                                    =20
  11 (***) [  33] Sergey Temerkhanov                                    =20
  12 (***) [  32] Caleb James DeLisle                                    =20
  13 (***) [  32] Junhui Liu                                            =20
  14 (***) [  30] Aleksandr Loktionov   =20

Another potential metric to add to the mix is what percentage of
postings gets an AI review:

Replies from netdev-bot+sashiko@kernel.org:
Per posting, people (min 15):        Per posting, companies (min 30):   =20
   1 [94% of  18] Arthur Crepin Leblond 1 [81% of  64] Nebula Matrix    =20
   2 [88% of  17] Jacky Chou            2 [67% of  46] Sagi Maimon      =20
   3 [85% of  26] Ali Firas             3 [65% of  48] Realsil          =20
   4 [81% of  64] Illusion Wang         4 [62% of  61] RealTek          =20
   5 [80% of  15] Parthiban Veerasooran 5 [62% of  53] Linutronix       =20
   6 [78% of  27] Ivan Vecera           6 [61% of  33] Aamir Ahmed      =20
   7 [68% of  19] Guangshuo Li          7 [58% of 125] Linaro           =20
   8 [67% of  46] Sagi Maimon           8 [58% of  36] Carlo Szelinsky  =20
   9 [67% of  24] Minxi Hou             9 [55% of  33] Corigine         =20
  10 [65% of  17] Satish Kharat        10 [54% of 101] Motorcomm        =20

And a series info request:

Replies from netdev-bot+sinfo@kernel.org:
Per posting, people (min 15):        Per posting, companies (min 30):   =20
   1 [39% of  18] Binbin Deng           1 [28% of  32] J=C3=A9r=C3=A9my Jea=
n      =20
   2 [35% of  17] Qihang                2 [24% of  33] Minerva Networks =20
   3 [33% of  15] Alexandre Cassen      3 [19% of  32] XPeng            =20
   4 [33% of  24] Henry Martin          4 [18% of  45] Daehyeon Ko      =20
   5 [33% of  15] Mahanta Jambigi       5 [14% of  49] Blockcast        =20
   6 [29% of  21] =C3=96mer Mete Kaya        6 [10% of  39] Linkui Xiao    =
  =20
   7 [28% of  32] J=C3=A9r=C3=A9my Jean           7 [ 9% of  43] TI        =
       =20
   8 [24% of  33] Rosen Penev           8 [ 9% of  55] Chinese Academy of S=
ciences
   9 [24% of  17] Bryam Vargas          9 [ 9% of  56] Chengfeng Ye     =20
  10 [20% of  15] Zxyan Zhu            10 [ 9% of 112] James Hilliard   =20

The repeated series info requests are particularly frustrating.
For all fixes we ask:
 - how was the issue discovered
 - was the fix tested (esp. if its a driver fix and author may not have HW)
 - was the bug validated/confirmed (IOW triggered to make sure it's not
   an LLM hallucination)
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#bug-fix=
es

People (especially those blindly trusting LLMs) don't add this info,
even when they post a new version of patch where bot already asked
for it.
--=20
Code: https://github.com/kuba-moo/ml-stat
Raw output: https://netdev.bots.linux.dev/ml-stats/stats-7.4
