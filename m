Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED73793B0;
	Mon,  5 Oct 2026 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186572; cv=none; b=GHlgxdXTv39b4mFbwJwbVfoo6tC6f3fRXNPjZhpu35Y34uIsUD/4VM2Ffrq7DDLQV/+On/k+z8Tv+Tx67Xnh0ku/WxJQZQ3ebMz6yc8szMfsEXInNgAKvH6yE7XfsV1jkdZym9zyC6MZF5/Wyu3RG9QOS2/JDN1b1ld1fWvJetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186572; c=relaxed/simple;
	bh=fquNA2mJf+8NBNA9r/V06LitZ7uIHtKXd0i6lJyYP9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVinwYymhD57rWZXBPVTcyfkoiIeOgjTdOESdPmaz4hs3eQYyTtFLvBKt6/F2twENzQ26+lHagXk4tumNuONuBi5O6FBId5m9g10lIu7bD8w3ZPn2Q1+XyseaWzpa/FtZl693O4A9sAWJed5F4mAvfuFvm9RFqgR68wZ0Y4mtzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=WoPoC7w2; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="WoPoC7w2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791186566; x=1791791366;
	i=markus.stockhausen@gmx.de;
	bh=D2bnpVF+SgXxpDyCqbRnnciBlyn+24yQAlvS/mVJX48=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WoPoC7w2uCIgxDfNpreLJ2KmjueTlPQ+HHMjxEJSd1FFkVlN2FieDVlgKbGMBcNm
	 v9o/borgn3ITAtMHW8G6cPQ+no/Ul+h2o1okf2bYSizD0WvfvZeWNYQjiT4nhmch/
	 kuFdJv3YEEcL6iqkjYChhZ5fYj8z5s+MAGhos5JvjrSGp0cPshA7lNdNCvRWtaX1v
	 y7Kc/9FDaiSLMxcMisoYztWNjiFPNmmP0rMpgJvbucslBOBNi3/psuvq9bnOZy2hf
	 toiwZzTELVPfdzNJwTnsleqm1T82FcO4UAchMYyyGO/bfdn7zCXJnrb0IlCPh7kdU
	 vHLLeKfBE16hdPszFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzf6-1x4FXw1eJm-00TC8P; Mon, 05
 Oct 2026 09:49:26 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v5 5/5] net: mdio: realtek-rtl9300: support non-default clock frequencies
Date: Mon,  5 Oct 2026 09:49:08 +0200
Message-ID: <20261005074908.1273383-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005074908.1273383-1-markus.stockhausen@gmx.de>
References: <20261005074908.1273383-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gzkQFKKplzbj1lpXJhmWWxKBdkzgTL9/N8czFiNh2WtMIHcjEtT
 CYkI0MzKcR2s+lqyZij9L3ldJz1PERSkjj39E7oAxHtpogVB3ODggn00VUPMCDaHajWm8/6
 N91TCmWu825sLx4wmOKLVd3XT7gm7ZQYLDZ+2VzaDgbPsii9CEqYT8i4iQdayujlu+ZdIR5
 zhg27WJPh8om6Pp/MJFXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QVhWC28pHFc=;4GihCofHxO3ynio2A2SR0fDU/IB
 s2RLQI+Yton/BR17wenAg5oFf2pcidRWwqVnpzy8EccKlldSG3IcEVRMWVri4/bxrcS47n8X8
 gkPCW0bZrP37PKsm5tk1MxF8ThAMxDY5nRq6NvW64jPgGi7nXh7ybGHUFGic6Ncvcy2uZoj55
 jkSKPEsUkp1PVqrD3lfWt5cygvKtTUuot5804QsCpTgfVC0mj3OiE6yDc/rFeqIYhwQ1Rn4kD
 3UEqyhbjjLG35ZpU9oGoTzhk2dInKwI5pk1zsvolWDdwNHCYKV73v3YJJ4X7xCqYhEA4KTxiS
 ZbdYSUUKi5BJ2gboLDIb44lAj+lxogdehi6TRNG2HvNLwRbskoNcIkrI2GIoLTaZYT21rnHKk
 N09Bz1iY5kOk8hV2GuovEHQ47+fr6LGZTpCrYoePXUkinVlgrbQv2VcT09IbLf5WrOHMo0b/M
 3sGP1S5Dr2uKNzpKrfSqEU5mxiM7ZilKiXb4i/0JYMaZdjv0RrjXv0/4CIYP09/f04HksnxEL
 iR5lrIWVWFacBOUPnWUZUAYCRVmZQeHPFNdh943ETcmaWunA0QEnDgyzEupJayPxZbDyPKv85
 CfChAz/yTpvM1lSME73EtiFGnPvOf+yJNbiqMDraV0sCwB5FOc2eNhMQBNKQ/3adMobCf0soB
 tGHLfL4gvPh1AsnjZdFXu91CCf1D0pSrb1alnrcSgpUtedOqsscbDwaCwTal3GbEzDuH5feZB
 tV71Cpd1wBBVZOOrazMCf/zrDTnCEl5AgnKJ6x705vUqM4dq4R4eyfY8px5NU+m6KPL9HM+H/
 um/5Y9RmU52c+26kH3kxN0rPBS8WJOIdQiCpmBUaSKT0lauNje+UzHXpjM/SdvatEyI4teEdG
 CeJLldxFUUePIxUwusxkK9qOLCgK6jF8B940/hp+JHt0blJe6+k7fpj22S/7Bb0qdMdWkfine
 It1++WNFjOMHG4TavpIFqTCCZkylheMFhGk8KL01gwAOGkw4HF6Rimc6At6FF/AmB9Eu9BZBi
 ++15c98zNTJKqn5aRuPAzmz2o8taG+zLalrJn93Gge1PnVBXwC52P2m5LaJyVa8LdJALKlr+r
 lAqX0ob6Ifd0dVfZ8BLKNcYH6N3VkU42jtlme+oLwNFfOctPQJfl8XMCocXtZQlIE2gueGNJo
 KS1z4QgGQXXyQVBLiIed7DXoh3wj91XDiyYky2QTxar8mihcO/0wOE765p5+UMMgIJOLsW6A/
 Y83nmCUzc0NsZWolTdL29FR5EXShhsX/Ca6UUVo+Z4qQ3l3LNh/YwZf7uHtgZQCI8QFY3goWA
 NvuT6ytCIvxLeMD4iso/298+sGKSGI1x1ctyzefoTrNhzrsAngskgU+GdEQY7/lIO/fgPxJjF
 Ej9mS+5mgcdI2jW7w4VD8kPm4F6LGgGj+p4TYm0uZ+nq/234fbxkKvLbbo7ET56XOMuZTsIef
 Bbfmz21GGjWHqVqGgSQHi70xxBqXnDivK4GPKiSDGWVpoKy9C7ALp75aWwyz96HhLPoP2rbp/
 7jvShZzRwmXFOoFYXxyQki8GxNuKF36uyxA2yjBvB/RXg44lcCssoRRXDIs1VI+Pppp5ugdJb
 qiz/EOs4fRbq1rZOKMn7CVPD2lb9WQ/4RqBtaW7wMBHQiD78/Hn2Q37NY+UJk/yBWfcuknayP
 dw64VXTq9mbOqZ11sGraeI853INFkaUgJfVG3EkgBcoTOfNlYTGC/iw1a+Ce4fPp4AqH+gkUV
 T1msZyt71ZLAoSBp7vHgVGUuSasRtbIB3jjiu3BrdDeBxTo6mZBjKB+nit4xeRgWXKYyQpq8n
 7H4sMtIkxrGX7AbiMLWfCCgxeeoaDRAqtoARdKYTd7+7I5OLD+semS0e5h2zDV10diZn1/tgY
 jmukkS9c5WEN0F/QkVABKnOLx7bw0d1ouM+UYOsQ1pMkebzwNs2ELIl3PiprNDskV7Zkdmegf
 C0FJwL7fB3jIgTrAk1qWZx9ZxY5qOYLSTVpDyDv5r1Z+YMhGKsnKrV5c8MYzNBNVSPBKEVJ0p
 6Obh72PCyyX2gb/2bxajC1xthPbD6sUAjPqYahCzZBCRQGWTtkudJQ4mEO8DSuyozCF78Dh28
 Yi1WxuVNphWLHvJjs7xhxbSxCxstmsZflh8QwbyU2G5QVscgq3Oi2slU6+cVV8oMTTEejC1fr
 9/XkXedN7ysdfDItrfr9wuu3dFz5Pu3X3lhc3vuqWWsoZhjAhyxdstXhyOVZgI/N4gDYSFPaG
 6Q/ngiXfhakQTHbf4feJlBPt7Tp0uAVJBQvzvGovA+d7DEKSAAomdukwxeFeTuuKokP7PaBP6
 wi2ZzF4KRsPQfUlLLy5aTzzHeKxlmXRc5BCs8Wd2TXwLDIgNE+Pe8ZHQk5latrDxlB0EPqKEX
 xU9j4tbSrZlbceGIFjiyTPA5oWEL0vN1KEv3Ttz1E75T1yWp0TaJu1aq1PlOYXsioL2Cu6MVg
 8XPAMUmoSHLyWHb2p013taneYNS2MtsgkKzc8hNDxk3rtlwBmu2l9zA793rrlRH2Jk/6iW2ot
 pY1rd20abZ8QZnEkUBEhtRiEQDtyIDeN+53U/d5+LUnR882vSb3cUUHs/SAn8BzWyr9omCyVT
 xqsp5gXv75zeP6v0zZpt5ziY5FTiR1EfZM93IArXEy1AA804bxkbUqPpaf8mDKZCcp7GxhrG/
 SnEmjBY8pMZ6sawGZTDsoKAbWyHYpfrtQLdN9yUy/I60KHiGoz7gZJ7M+VBOfvG9LWHX2IgXi
 O1owrRJ3BDXdvwmjwgrd4671WHyDz1aIaSfDxV/aOLCUOzS99oH4i8zDA0CuoQtAcvN1TG1Cz
 2plNwE7KRuM5skODJ4KfZx9QLlmf5NU0gxiTVU3zLIXpwnEpEDVfQM1BoskQsxlHlI9n9kptg
 7I7tW0ilF3SwCXzLuvqTPBVl5jCzPM2h0nODJOufIO3wYHJFB4RXXzyzsA0ZjWJUYyJ9Af2dm
 N4BCDeEiD3XLRymO/rSCijboggaGZ5wb8TVeP1/LuubJ0InBOR/e1bL1ZzzguGjtAN6sEFz/f
 9P+8LRZNJmzshVyv2lqkBcYnvLnmc6/oDA51ggd11dihFjfaU1Uw7xSuKGqiw6xi4YR9sjfa6
 0GcnswdDl0d3yebeJ3yc2A0pDG435YWxFq2i34mb9afvzCbinXf+i6JJMqg++Es9z1dS7Ggg7
 8iAYLEGVqzYRKjtL1nAD2ot7qZ0YxaNP1Aq8ld7LwruYHcxgP5qPoas9Zcs90VdAoccu7himL
 0VKa7SRjkxQaWP4eHbwMXDmcQcUberhP2oCcjHinupywLm45urFQNEMwOTNrlMvAp4K87kvDu
 KkqNXEBWbZqtEI+qD/WCpPwipKG4gvbb/6u/IRsh/d00ExZI5ZM+f/h/JJAwNwRMFMmX9Xszt
 ehJyFkp2MM38BiHabWg6sbQ5h9XE+J776rb7qOp4mjg+3LM2vsOPLQPePxLZdMFgHrBzmGGRQ
 /vqOAS5zNgO/euGTGJKS421Md0NW5jgmjHVStEyUyz2yuVHEf4M7OGsbmvTropqsD86Q68Aew
 nrYGC57ZZx77sZW0+TZePCVtkqMrtDdejOPo3MajIEJhQOHmCSRKcivFBNYkp2BRd+6LosYt1
 /g5g9T1zKU4eNv3kse2j3dW5yEJU/r+i6Te8eNJCSsaODuyjAIpuwuEvkUcfBSmeRnvvnA6Fi
 BiDAEcNTBNfd5r0Kb1sE2bYRklHFZ9Kogc9fQ5sZmboohzxUKK5ZyKx4KzIfD12KvZR5Ctbkk
 fN9G95zNUHaFBDsxz5W2s0ZgDAcTFH8aUVwwimK0vBwAM8xBK+qTf9FS+Bi2lvHyuYKVRs0+N
 lP/LzjXzDFjiPEtNjROHRquWteUwQFMR4HghBdQe1zXS4KB3uKNMtcuu3w5CAHHKtltp6HJWN
 AKDOPQN+yAzGhhuFyr4VrNaePdwjuo4W+ouaWxJjG70AJMOPO+qsPgCVtvuEBxVYxt7J+17RN
 N4z7PDeYDWWsO8kfpD5fHuwqasHVcXn7Uqg4JT8KcNUXtVIa7sPencn1eai3KKXCQagl3wdyv
 dkSDBa9pj6Ze3XD5CDDaVI6PwrVHPGPYbLsVZ4IQQhHn+bZIriPfZa2YNECcacd67rAgqkWSZ
 Cbqlslye+I6g2e9zAr+2vydZiq2u/9M52WFmrDLyi2wtI2/MpB/dwzOzfuHy67dkNNof8UZsh
 +yN3s9uNu8aYVUNaUdSN2yQS5JaVYRsHjfJdavdZP/dKkqLCB3bZJVe46OgLXNC5HGHjBWqVc
 vRNOypUczHDr41yVurek8BZbAQz+K/WX34smReJzQQvkXCJxkluPrvGJhRO6mMOmqvpQyCDNm
 hkoAHpY3pb/Iq6dtqy/8S1KDPeycfFfoqRuF9R9/y1a+mKEDNjJFkaWgR8L6XTVPIdho4q+w7
 egbMzQPG+5Vw7eeoDyxt3eEZ124yj7qWheyDNA26UPhx3RiiC3732VNpyqjl1mSZvi7JiLhuR
 6/QqJIHLod0a0wlYjyv46F8co/LYu7EDaV0KYt7ZG9HybzJdExOED9T+ll+3pQQWRLX2JB31X
 zzAYgW0gPCz5hrQWK4daCrkRDMxPwPmgYw6qN4E/sPQVCUbUkaVD0lDBsGrZ13B9/KZrofeWu
 wfK7ZVDceDmYfr/4gXLZlptkQhYKNxEBd2dF/aL4kY/uipkYytw4wU60nIh73GVcNZTc9dUrE
 fanoDKmcO9S32fewDvXsk+uFUM3AVSQNP9wTZrRup9I339WBo/ZGGVNF2o0RZO/4zfCdf5bT7
 FESiZUMcwgEtHwJugEDWjju4EPEJXbywRa4niDvRk35SyUaAMhZ3LhS49VJjppjRXty3WBJCM
 kZaVjYq1/e012NseAgfOIgh9CU3ApZlzFD2Uzv9/B5zOVnloxLv9W3cQHZudmjWuHD4zpoeYC
 nvyz/coJJMNU//a4us7F6Ba6kI+A02GNYJ5NSoSY4ANJePPdZmzEIKUh6Nnw4Jxnv5tbzSBiT
 j4LeYIRmoAfCshzzZYOGmDc7Nf2+mjPsAQAnVacpiy/I/lBeXKnDb4XLWnsRL7YmTkEmOU9Ou
 nkBIxnx/eniYSVunw6//wCiGHm896R63wCUh8gCeR2ZjStkAZKMFx4gIfDN630PRhn7h8HUu8
 /BUStIaV7M14pvvQw3nIRED8auXRDkYI7OQ5pOfp6/Kkh/AV0uKJkg0t+IktmSzxrqkt7NuRn
 ofP5KQxgLvrn5dY99hk+e1Q0D95jfy5oAIeJtWKGJvE+fE7xcakVJ3/nbG2riN9FIefWv+Stz
 DuhUogiOYYvA6EMBcXskPD0ocPgCTUsvNPSdzJFyMi6cYW3pMSMcNFK+tmqKniW/drqzP0b9S
 f3gH2bg439CmNSo18GrhuJOS8Dimzzorpoak+m7FwlDSVC/AWsSQZofohv2VWOV7fU+b2WFqB
 um32a/ycMSgv8YfceF5wNw7Dq39hKvw54ws8XbHbGkjsdMQTrTQda4Q3KNYpUgDCSu+7HbLuy
 7bX8+fKq/ELBe+fRlHO65FrNBrd9Ugx6nnpaIh4cuyhJEVnXCAJS7jYa35GZ9JYze/6KwHQBl
 w5tWXsPKMqmLEqRwbnylY9bKS/EM3s/Z9y0383kxADR9nP3WUmmfNQSBd1l+yVWzGp/4u5xFh
 L2aZtVWR9a81aaSmGbZoRWWlW9ejW/zho1SbbJdk2Cw//+sAuLntfwSpu5YSqd0U/xuQhW4Wu
 A3BgSq+9VB/EIZv41b2PP2NeUL19tYzwX0UF997JoI/4PJkFjFob9Xqm1hubViVvcqF4HbPA7
 8nPORnRv1BcwOFnTBPOIIhDG+8D1Kkx1WMSZIzbRJYB0kxMSqJYFBus3pf77ahzZqG+zEL1ak
 gC2yLmpT9KSYGa2tHuVcJInL9tVpx4LMkmCh4ukidzORYvLCEJrPAcFNBblI7L4dI1rSuwLm8
 g5h4QbeZnEZ+bZv24KdW132syn/lESKroURpwfiQtDvYhQnKRXPP8ySjoTz0psI8tkVX2Df1V
 DHll50UL7OOw5XxhuWkcYusWiZT9yYT+MGfybv4jeYfSjesaJqZ01X8Rlonj9MBL8C3MMtv1u
 9Mm0s6BdPtoT9N2E601nCE/U3NYX6TylBs17fSQqa/Xq00k3+RFvsflrwXJfvpvmKviBiFcOF
 ATsUXEpXc3wNx9hARn1Ckxrvn0ESI2i8Z7+WUpybRqEsuLfLwmSzlLDVhM8WzMow9bg2r1DB8
 aQO+r3JnFfhSe9spsPDqpKqK3bGjLHA2bYLZvo3/TeaXGXfa7ZSJS9PM+W7ERZRqLRz34FrVR
 3NZoDEKv5HqEYlanlI/46uQwNnXsfIkPv9BtivLVdd7iafyVCjdnjZGcxAPKdIsE5jdU0z8W+
 0lhJzexH6kpj9yMlZUBtHc9J5rA7QKyxftO/rd7LKrUelMtzfpAtfyvEGpwVHhev+vuEfzBhB
 zRdmWNbK4dZpEjwQ727gKm/83YwnuYjwr3Us7ROKRVS/gfs54ed0OHQpGb+KLhM6VNn0TkEgo
 8TyabiswRkNA+bSDt3RE+aXThZhyOqoTmIbO8OSMJU9Y4244lap4dmbJ0nIUZy5bxWF8Yn25c
 M/9TARIzYPY/ca7aEuNHcTM/CT91ILmgScGZmyYUFusNNXZs0j

The Ethernet MDIO controllers in Realtek Otto switches use an MDC clock
frequency of 2.5 MHz by default. Hardware configuration fields allow the
following frequencies to be selected:

- RTL838x: 2.5 MHz or 10 MHz
- RTL839x, RTL930x and RTL931x: 1.25 MHz, 2.5 MHz or 5 MHz

Add support for configuring the MDC frequency through the
clock-frequency property of each MDIO bus node. Lower frequencies can
simplify protocol analysis with a logic analyzer, while higher
frequencies reduce MDIO transaction times during normal operation.

Program the frequency selector during every probe. If clock-frequency is
absent, select the defined default of 2.5 MHz. This matches the
configuration observed with a protocol analyzer under the stock firmware
or after issuing "rtk network on" in the bootloader.

RTL839x is an exception because both MDIO buses share a single frequency
field. Use an explicitly specified frequency as the shared frequency and
let buses without the property inherit it. Use the 2.5 MHz default if
neither bus specifies a frequency. Reject conflicting explicit
frequencies because the hardware cannot configure them independently.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 100 +++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 63ffb7f82b98..eb7a6238dbd1 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -129,6 +129,7 @@
 #define RTL8380_NUM_PAGES			4096
 #define RTL8380_NUM_PORTS			28
 #define RTL8380_SMI_GLB_CTRL			0xa100
+#define   RTL8380_SMI_FREQ_SEL			BIT(1)
 #define   RTL8380_SMI_PHY_PATCH_DONE		BIT(15)
 #define RTL8380_SMI_ACCESS_PHY_CTRL_0		0xa1b8
 #define RTL8380_SMI_ACCESS_PHY_CTRL_1		0xa1bc
@@ -168,12 +169,15 @@
 #define RTL8390_PHYREG_PORT_CTRL_LOW		0x03e4
 #define RTL8390_PHYREG_PORT_CTRL_HIGH		0x03e8
 #define RTL8390_SMI_PORT_POLLING_CTRL		0x03fc
+#define RTL8390_SMI_GLB_CTRL			0x03f8
+#define   RTL8390_SMI_FREQ_SEL			GENMASK(6, 5)
=20
 #define RTL9300_NUM_BUSES			4
 #define RTL9300_NUM_PAGES			4096
 #define RTL9300_NUM_PORTS			28
 #define RTL9300_SMI_GLB_CTRL			0xca00
 #define   RTL9300_GLB_CTRL_INTF_SEL(intf)	BIT(16 + (intf))
+#define   RTL9300_SMI_FREQ_SEL(intf)		GENMASK((intf) * 2 + 9, (intf) * 2 =
+ 8)
 #define RTL9300_SMI_PORT0_15_POLLING_SEL	0xca08
 #define RTL9300_SMI_ACCESS_PHY_CTRL_0		0xcb70
 #define RTL9300_SMI_ACCESS_PHY_CTRL_1		0xcb74
@@ -195,6 +199,8 @@
 #define RTL9310_NUM_BUSES			4
 #define RTL9310_NUM_PAGES			8192
 #define RTL9310_NUM_PORTS			56
+#define RTL9310_SMI_GLB_CTRL0			0x0cc0
+#define   RTL9310_SMI_FREQ_SEL(intf)		GENMASK((intf) * 2 + 5, (intf) * 2 =
+ 4)
 #define RTL9310_SMI_GLB_CTRL1			0x0cbc
 #define   RTL9310_SMI_GLB_FMT_SEL_C45(intf)	BIT((intf) * 2 + 1)
 #define RTL9310_SMI_INDRT_ACCESS_CTRL_0		0x0c00
@@ -270,6 +276,7 @@ struct otto_emdio_info {
 	u8 num_ports;
 	u16 num_pages;
 	u32 poll_ctrl;
+	int (*set_bus_frequency)(struct mii_bus *bus, u32 freq);
 	int (*setup_controller)(struct otto_emdio_priv *priv);
 	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
@@ -745,6 +752,17 @@ static int otto_emdio_setup_topology(struct otto_emdi=
o_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_8380_set_bus_frequency(struct mii_bus *bus, u32 fre=
q)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+
+	if (freq !=3D 2500000 && freq !=3D 10000000)
+		return -EINVAL;
+
+	return regmap_assign_bits(priv->regmap, RTL8380_SMI_GLB_CTRL,
+				  RTL8380_SMI_FREQ_SEL, freq =3D=3D 10000000);
+}
+
 static int otto_emdio_8380_setup_controller(struct otto_emdio_priv *priv)
 {
 	/*
@@ -754,6 +772,60 @@ static int otto_emdio_8380_setup_controller(struct ot=
to_emdio_priv *priv)
 	return regmap_set_bits(priv->regmap, RTL8380_SMI_GLB_CTRL, RTL8380_SMI_P=
HY_PATCH_DONE);
 }
=20
+static int otto_emdio_8390_set_bus_frequency(struct mii_bus *bus, u32 fre=
q)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	u32 mdio_bus, child_freq, val;
+	bool freq_set =3D false;
+	int err;
+
+	/*
+	 * RTL839x uses one frequency shared by both MDIO buses. Use the frequen=
cy passed by the
+	 * caller as fallback, but prefer an explicitly requested frequency from=
 any valid,
+	 * available bus. Reject conflicting explicit requests. Only the first c=
all programs the
+	 * shared frequency.
+	 */
+	if (priv->bus[0] || priv->bus[1])
+		return 0;
+
+	for_each_available_child_of_node_scoped(bus->parent->of_node, child) {
+		err =3D of_property_read_u32(child, "reg", &mdio_bus);
+		if (err || mdio_bus >=3D priv->info->num_buses)
+			continue;
+
+		if (of_property_read_u32(child, "clock-frequency", &child_freq))
+			continue;
+
+		if (freq_set && freq !=3D child_freq)
+			return -EINVAL;
+
+		freq =3D child_freq;
+		freq_set =3D true;
+	}
+
+	if (freq !=3D 1250000 && freq !=3D 2500000 && freq !=3D 5000000)
+		return -EINVAL;
+
+	val =3D FIELD_PREP(RTL8390_SMI_FREQ_SEL, freq / 2500000);
+
+	return regmap_update_bits(priv->regmap, RTL8390_SMI_GLB_CTRL, RTL8390_SM=
I_FREQ_SEL, val);
+}
+
+static int otto_emdio_9300_set_bus_frequency(struct mii_bus *bus, u32 fre=
q)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_chan *chan =3D bus->priv;
+	u32 mask, val;
+
+	if (freq !=3D 1250000 && freq !=3D 2500000 && freq !=3D 5000000)
+		return -EINVAL;
+
+	mask =3D RTL9300_SMI_FREQ_SEL(chan->mdio_bus);
+	val =3D field_prep(mask, freq / 2500000);
+
+	return regmap_update_bits(priv->regmap, RTL9300_SMI_GLB_CTRL, mask, val)=
;
+}
+
 static int otto_emdio_9300_setup_controller(struct otto_emdio_priv *priv)
 {
 	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
@@ -774,6 +846,21 @@ static int otto_emdio_9300_setup_controller(struct ot=
to_emdio_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_9310_set_bus_frequency(struct mii_bus *bus, u32 fre=
q)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_chan *chan =3D bus->priv;
+	u32 mask, val;
+
+	if (freq !=3D 1250000 && freq !=3D 2500000 && freq !=3D 5000000)
+		return -EINVAL;
+
+	mask =3D RTL9310_SMI_FREQ_SEL(chan->mdio_bus);
+	val =3D field_prep(mask, freq / 2500000);
+
+	return regmap_update_bits(priv->regmap, RTL9310_SMI_GLB_CTRL0, mask, val=
);
+}
+
 static int otto_emdio_9310_setup_controller(struct otto_emdio_priv *priv)
 {
 	int i, err;
@@ -840,7 +927,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 {
 	struct otto_emdio_chan *chan;
 	struct mii_bus *bus;
-	u32 mdio_bus;
+	u32 mdio_bus, freq;
 	int err;
=20
 	err =3D of_property_read_u32(node, "reg", &mdio_bus);
@@ -873,6 +960,13 @@ static int otto_emdio_probe_one(struct device *dev, s=
truct otto_emdio_priv *priv
=20
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", dev_name(dev), mdio_bus);
=20
+	if (of_property_read_u32(node, "clock-frequency", &freq))
+		freq =3D 2500000;
+	err =3D priv->info->set_bus_frequency(bus, freq);
+	if (err)
+		return dev_err_probe(dev, err, "cannot set frequency %u for MDIO bus %d=
\n",
+				     freq, mdio_bus);
+
 	err =3D devm_of_mdiobus_register(dev, bus, node);
 	if (err)
 		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
@@ -1061,6 +1155,7 @@ static const struct otto_emdio_info otto_emdio_8380_=
info =3D {
 	.num_pages =3D RTL8380_NUM_PAGES,
 	.num_ports =3D RTL8380_NUM_PORTS,
 	.poll_ctrl =3D RTL8380_SMI_POLL_CTRL,
+	.set_bus_frequency =3D otto_emdio_8380_set_bus_frequency,
 	.setup_controller =3D otto_emdio_8380_setup_controller,
 	.read_c22 =3D otto_emdio_8380_read_c22,
 	.read_c45 =3D otto_emdio_8380_read_c45,
@@ -1085,6 +1180,7 @@ static const struct otto_emdio_info otto_emdio_8390_=
info =3D {
 	.num_pages =3D RTL8390_NUM_PAGES,
 	.num_ports =3D RTL8390_NUM_PORTS,
 	.poll_ctrl =3D RTL8390_SMI_PORT_POLLING_CTRL,
+	.set_bus_frequency =3D otto_emdio_8390_set_bus_frequency,
 	.read_c22 =3D otto_emdio_8390_read_c22,
 	.read_c45 =3D otto_emdio_8390_read_c45,
 	.write_c22 =3D otto_emdio_8390_write_c22,
@@ -1107,6 +1203,7 @@ static const struct otto_emdio_info otto_emdio_9300_=
info =3D {
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
 	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
+	.set_bus_frequency =3D otto_emdio_9300_set_bus_frequency,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -1133,6 +1230,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
info =3D {
 	.num_pages =3D RTL9310_NUM_PAGES,
 	.num_ports =3D RTL9310_NUM_PORTS,
 	.poll_ctrl =3D RTL9310_SMI_PORT_POLLING_CTRL,
+	.set_bus_frequency =3D otto_emdio_9310_set_bus_frequency,
 	.setup_controller =3D otto_emdio_9310_setup_controller,
 	.read_c22 =3D otto_emdio_9310_read_c22,
 	.read_c45 =3D otto_emdio_9310_read_c45,
=2D-=20
2.55.0

