Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E21FECBA;
	Tue, 18 Aug 2026 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075128; cv=none; b=a1yGID/CgpUZO9sreBzM6n9QgfvYcbHCWwxxTwE7au+K2XA7UoBVQyGsSaN0aGijNCOmko56jntRnfQdM0sc6l4cuCCe+CvH54pn4clVHkg+Zlm/Hi5x4wwQUGgefOM3085g2yoZG4yJ2otxCVZzsRm7Pa1WnpqBd2QA59rDfAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075128; c=relaxed/simple;
	bh=tXWBAFwvRLMqgRvMI7xGZz+GM0AyZNwiBOnphBaYc24=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=YYxIJR7sjwdJiSUYGc3YIaGthEQU3vDrpqsGrAU8FxQZqDQlnxnSnc1mXh3vGi+fhowrTkpWIV5Ltea+mR1+LATIvWTzAcsjZi3C7avUE7NlkYxhSvNJ85ceSc6LnVspLJ69zLAyTNS2+FRwWZlkR5LiQXHEsQvkbZ8ZS8IqCVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=N+ZtlWuh; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="N+ZtlWuh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1787075106; x=1787679906;
	i=markus.stockhausen@gmx.de;
	bh=cdWjUcWzmYgQJKQ2kz3QtYI3j2sVbqCQgJMKK+hG+Q0=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N+ZtlWuhyTLv+3hkjQNDJ/8NKbi42Fa/kolJN4WZPM6gIawra9c+RL6Gf0eBM3Qz
	 hMW5xQ3YoUvc1qAoVPPQxOc1qNSN09XLNJbMSRc6yiSExkpN3LsDiNyyOeEofNGzc
	 lFFGEeCDHqfE20zhfj/BnAfYAZBy8smMp3QIYP4PCq+NbXSVUlp5HzSdTjqtK5Yiv
	 lZS/RaJK40TolXwbQxWR3XkCy62xk+EnDYVMYVh4b7GGFY2orfTuUMFKInMMkEMsf
	 bctpplLJAv7v72ng+pilVCbVPFv61SpYQUiQjpoNwd7UuLAn6fUqdAMS5HXrz3nVC
	 wFRisDUCKR7NgeYlPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzfG-1xNQvo0wZ0-00QFu7; Tue, 18
 Aug 2026 19:45:06 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<robh@kernel.org>,
	<krzk+dt@kernel.org>,
	<conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de> <20260817162632.1208891-11-markus.stockhausen@gmx.de> <cf8bdf97-64f9-4120-bdeb-c5a91a274490@lunn.ch> <070901dd2e6d$f5b70c30$e1252490$@gmx.de> <0a125ab4-2453-4d32-b158-8bdaaca16674@lunn.ch> <089001dd2e83$b8957920$29c06b60$@gmx.de> <2fd17092-753a-4a80-bdf4-72801eca8d0a@lunn.ch> <08e501dd2e86$98e9fdf0$cabdf9d0$@gmx.de> <ecc68c5f-02cb-4249-9f09-f161cc97a989@lunn.ch>
In-Reply-To: <ecc68c5f-02cb-4249-9f09-f161cc97a989@lunn.ch>
Subject: AW: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open up C22 and C45 space in parallel
Date: Tue, 18 Aug 2026 19:44:58 +0200
Message-ID: <073901dd2f39$4e234ac0$ea69e040$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKGRKDnP2yh8sOJ5M24BwCNtDMK1QH1jg89AffL5+ICqsGtjAEuNNjXAY0ikhsA+OoE9wK1aKQNAWI90ly03sJNUA==
Content-Language: de
X-Provags-ID: V03:K1:/naBk83jKbvx8rKSnfVAfYpBXX3YXOnuFwnNad9qikYP5qIx+c8
 Su955wSO84LWrRGjDae41SZK9IuMFLwDBNJuf+XHvF3VpqrIRCLouM2pWq3HLlfaEg5EmhY
 qUO9Ggh5rFe3JTPAKR09X8EVYOxp8jmbgW4vnSMAgRBKyvcGS0vzTRIzb2BrRGE2fDOS88m
 cg3SEL7QlgBJYjazxC6cg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zuJOcxoIirE=;YE80zxs5WCMJpXChwNLlHB6EVcG
 oc10JxCvCbDLxUDrQZ7WTno2Rsdkdk4++1Mn8rDxUOONpOLAbqTBgdVOde5ZrmBXU/muCWOP1
 hJbUAtYILvxbfHkh9SYsV/dLKqlDkksGzOZ+CyYRklpc1hzPSfeCR+OSCs0zBZXTFNs8j2aMe
 5p0vG/uqtNhF7QbfdhehYZLzsVoa4Ss4JznjWRwTS5xxJu8X8ESlpbk81XqeeFVb74a2awOgo
 /N+YjUb7bb1LcQK9946PDHs1ew8ofHCX5XYxqyxyDVWu4jZwFRlvjqPxPwn7ZZ1KzndiGgT8y
 E1B5DMXtDAo7bdEXnOa/gCIzTb8t414MjUC33vxzqr3VPXyzms+0tcqvk1HRYKpjvJb0reAta
 D64hv1foGXc8LWE/ntDdn/EaBfCID8pU9Jr2kjWGwM2xFdDXRTGs+RiWKx7z0yE+OaL2sim9x
 p2NjPVDuFDW9oQzTx5R1gyq/RMfZXP0O/J4rNvvdyCfhXbVE9CfRN/u9CmW0mfcTYiCtejOLV
 c6hDFvW1hD1dngv5D+JPociEtA8l6FR6DQmp8/rc1cGhfC/z/hREBvWg1MiuEep/bEkE8X1dF
 UxPFJl1prGJ+smmycD4vysSzlAow4rvA7WdhMXIyUrryzDcqpfMebYOYSp0P0F9mang8EtXEq
 0DHQrG4DHGGf5VESp7zF50CVE0kArHMECUalewCxeCVsi47lr1qrWiol6mvPnp5z1yXK4DnZr
 VQ7vHiMm6dUduvSZqusKoPu9D0oYp3zZ7QwDBhy475V2/GrMUDx6Cq4FhcRYh5lReacLbM3lS
 /fdhXg4E8Z0byBrp3xyn8z2wMsisEIk7GX2+/39eZ+bBKqobd7G5v67q6XBnxqfmOG5kAn8Td
 4KYD2uJN6Rla2ZfAMQ2mivSNvt6OYYKbGbg1pv5Pw8DAgg/nPmuvpo5E2vT5i4JPYYOjUFTDf
 DiTDCVBDQXUQv9O9S7dKWOydKL1BMcMK0e51mrRBI2Ccx84adit1yFwTNILciBML18hdd/F+6
 AuI66Oo0xMOZmDMNQyN1grXZO/ub7i5dJL/8qe9+wq9I2uBy3bZdHgsIVB4Aiyredrf2DAo34
 vyeWRrK3KknuI2HZnf2OnEMrKFqXf6Udmb5+cQjWIvdGcVJURK7ztynRRRJ6IIlRyaQHsP8Bh
 vCdEN2ZrJeszyweRYZu0B2FdtEy/TAmOezxEylCMz9pOv/2xMpcrWYb9Q1DWvoHLw1t55/L4N
 IHC7rKN0nEDl6ryA+E98BZ/SY+BzFfNUjQiNvyIPkVe6leod1jFNg6JMVSZDXSSuxkhasm0V5
 yeWEq4ikhTXS/uQAw1ZeDMJGlfG66XYSn9qqR0ks+ZDoZQ0RE0twYxnP1H4evYqJr94/iuSy/
 jSrEsOXi3K23As9LWpYU5kmbOVnzl36k/j60sKd7i/EjGFGZG0H93a3lZkCdusxZAJzieVevx
 DrjrmvC8gn3y5KXnYpVsWxKSGH17MWAzdF20yD6pjm7jNPMT3YjVpMNdHzuWGgHXUVbdctnZB
 YVKmOX4Q3tlxMpcmbs3qW6QSd1yKchPH7jmSNGzbOT8FwCB6cMzGP2nvJgyPk0w6um5mlEYrf
 m655WqVar52bfEyG+quAh4RisaHKjdHCfWrPm/26yTnbryW2/+0eg8Hbk7eC1lgurUGXL/DPY
 bJLhEbseaH8lxFeYZyhEjGJxUky2EgTrBPzP+GRKhfOqcsAnYYmL5lGMHc6PMMSrzikzWikK+
 tjVvt0R0M3/ykNgmSOzPXD2H+uL4xRkxrTs28SpjkxBBc1vFVF42wwQGdMpyGCqi3d3PufSss
 iGHW7LdwaNO/4kMZGQRhBEN9KIl6faqqjrayRefNoe+EMwY+OH86ryXtc8Ci+LJRZBPokAMz7
 Fn49hrhmmyGd972TFCM46ExShFDnqWoFnnzKQI36AIsogVxmNY93AW8uqWT1+UIhU/yaHxusU
 qOpdxAzzxUCGvLcsNOXMBwk21CjenaytugfnJRKi4MRKPCyuZc4IrayC9YM7UYSFjUANEi9/2
 I4poT2fs/yQ/qfeLLn3ucxVVZ6TDY1s7fTXQYyGNvYoKRyBo8WiP18kjqO8VEK4VSEsiCpKmZ
 XRBWRp5IklTs3LOvoHpQ0g+kOqKdQ5uuAPWmZAkcrfwmM+L45NzEDjShOpwDKlnnuJRHsp07z
 Q8uQ6OclQjfukzG2dKg9fDzmFcMVV+cqCDp0KJX68QJY00Qj8jAY/MXXBopoVQrz2Vn4v8cTa
 kLsSo11HAqAlDZFQr6niBIlRVS7BEQ4cMLju+9dS0Jm9mYqZiY5VksTXRv+qSiSTmMH0sP4NU
 LAJL+vg9PH0UOR/zs06cr135n8Ewla+A9qB6s8HaXSUosC/IIfzm1kC6T5H6T73hu0GV7Ty5z
 +32boMQrfGBfT+MvAxpMesZkucEM2RkuJra7u+cATFZW3TSx+qIE2pkj8lueVbBxHIs6nxrcX
 el3sEeBuPiBoF3Rws5V0z93hIxfkzJOrrjYAxxXnsKyyswSrnNhueBxVaY/I31aCcYF0X022I
 2v6LqikWEunmfK528CwsW98ND/IbWJFIERa4+ss04zB0A97A0z3WJMgXTTA8PjYZ3XttfBmcM
 t5AzNEezGEphdxg+xcDPo5oyvIM+aVSodWXzlzAJHQOQEFj2L+JpAL+pgSfXnJGit/VL29kDe
 QzMmeXURHHDUMk23OYsd+XKGG62bsb6+5KTZepuacnUd1nzXuOJcyG5rFYNPb23slzhSdFmGj
 iBtGX/cQfCMFQ+KdQ9zyM3l1smQIzTrvTghI9qnSgvJZFoF5ZJbAw8C1K1NkfcAr0qVh3ZAX0
 zvDIiuqehM2m/cQijwuv6srsKPsjDTrSiGKEJsmJDmZ1hdfdhgRU7vx2ZKOL0BkrWhl/+zhjn
 J4mlePK/PvUrjtsJwajecMUs74MMGlUhNNTp3qkl8odq7/HjLHpfS8crQ1v1TWKlzMUObsi6F
 1zCZ3zKYedEQnYKrU+5vDeLyuKCtr0LDMe/h16bMTKuwcDnI1Pho2vd3QBPVLfItn9/UYFrwq
 WJZclm1elXXyQsrPV6Zqkrf2huAfcmzwqKAw76hI3JGR/kvyphXU/ORXWIwmHqXFKnIaqZ52H
 7j7Jb51SIYqvtF82XO7T0q+9Q0dQg+aFX1enwX/aAz20gmiBqHIsDjGdvRjpZ3yqLVxAJd7Z6
 xs7aVOEZVCUk7ik2OBjagYl4BWOG5an4JtnJ30U8nxlmWJ0qUL70i4Rcae5na1jnCdShfnui1
 x8QvHnFiRKyncD8sc0wt1Y5ZYTB/hBrha4A3ogpIfqgHxnalEUGT6nvacIbtWbadPSFmnUDe4
 WW81ToPZlEntgyDsg+eVAaY5p0TfUWTcFl2pzkgggNIOzEWiG/pw/+mNFfzqGtdodVRJllP49
 L7QgBNjWUzpHxWd50DykwH/V7hCjbr+e88Yd2KgOWYXxsHjnwBUF9aEVOR0QT7MRPKkYYhw7K
 RvynNBaAuqKAy69jWh0IsqP3ZcQtnlF513Cf5F9uxSw0T5MkOyJXjN6B5TLkUFKcaMdng4XUi
 8VDHyWX3I3iLz/73J0rryELbb1z6ebIXfFUElRIjbO3Mxji8ACLpheNUZOS0nWo1Y0kr8rbfm
 JLhMn9ipNPXlvgxPxOablHOcpduGE8JhuuFmUvZwMxpJeH1mmA+F84dEJNwt2jLj/PVG4NGGi
 JTxX7e9APoMgKzzYn5aJW+52Ds0GZyh07r6xpKur2/duLlV5/JqGMAIqz4aCkLJSDXVjTFfhF
 5jZnIoNXgA+0jBFMaMj20E1M/8UIWMm0zu5MMgBAoi16m6XBk5dkOmYvUaYCqlacv0uyxdwiO
 oN3UhTngZqaLpQLU+tMrgXxHePZRmp2phaFRfBYh7dvYfICt2AApqRAqeAny6TXRz3nzgqh2J
 6uXW3pL++D/l/GUNJGo67MpZRfFjURZcWaKCnVq/UzJiTsPM9smMxSr6E/Bbu6uQ7ZSXruihp
 oJRtuVzGCC0WTINdJAlywEtAumJmglookMcRgA12RSLZCGnqr2TEcGyz4m7eenTvJBVrY7nXR
 Qlc8jhJsG3e7EzZ4WIBr2r1WuCW5MLkpfrFwPuEpRRdLf08udmE5DKLh6GSUWpYy9tnHBpY4Y
 ZUVZHFzSgi+M5it3WFolWn3n5l6lrgR04VANjpiP18E7tJo6YvamA5wr84X+mrkPPQ31iyZTO
 gX0pu8zGxf4LlDuHX3nfEseJ1SuxPyytyyHitT7lOE1vyS+dgd6dR9RrBjqPXlZeF0Fq+vTUd
 xZ1Op5kewcyZ4mFeBmOaByf1o45ich+kOOR7yw9lFjoe34TjdLWLPIrzD0Wba6jk2eXYjdSHf
 x10hD/JPc8k+TbzuHNmcSxPYofVTX7u1YNxrgqi1Hm9I0qgLo6a6Z3mNzdXUx4aT49VbjtUqp
 9mCMp5OzhyNBRUGXhDA/xWr76/DLAml2tNs66bdzNSLgBYCH1khTaQ0zVlkPvG5EmvgFQFSvV
 C1yoClYGYqcHRvybdSsL5OKUqlJjEXoUNqjpm1i6C4PyuIJRyj7N/R5JmOI6Wh3TD3Uotipof
 7B13ZKRH+JolNlMJnl1fPujfLLASGPaTtTiTaS2AbwqOc/EmzWqdZYAjZmMflA1nV31ywPSRi
 YHL4XnHO71CbO0uaXukvqV469eYKtcnp+yZ3CUvIWvFr4dZAocLzmiJUxnII8+c6q9jZcL5xE
 pWHj565CO8v85wesyA7syjn3VtCo4vElTokFzOggpFpXWAT33qofLlc3t4n0J8EubXOnBIUHc
 N6MBaAglAdwgbcPxPxTHGRxQAk7J//egg2mgBjXxAqDj7TIG0xmX/iN471wZqP0zqMXKIlt6N
 Lf3nOa5bZTiBsAX/IO1loRn7o0v/3FJGJJBSIzCgvLQsgfqUWTAPAI1nBLn5Blztw4y8NtDSp
 TyyxKHV4Xl5CRDyLEE5IrWXBi8Bc5kGTS+Ekz35QKpUEvGpqYADNWj9g6AYd5TsvhZ+zY7pWK
 9hBsr8lrRL8NvUicBPIYBrnzs38Muczj6lp7h4vqe4Yw6o0npQIl9ys18FJIX/q+/l/6eK81y
 Oucxp5jzoPrA9Uwl6yg2jgQM7ymOB7ZgaEYIOPb3eqV5PayR8dKsATfhF3kKu4eqp7JIq9/gb
 /PwQcEJD9VsCBir3z92Do0kWM668ec7VZrPSO5XZxiyhoVhMTp39x8AQ2fR2aXuo8OhvPiSJp
 /oL7tDiZD7fgk8yWZz17yQ00j7y4x1rUG0WF7hbOuNq5qjt3uuoUu316fidq2u/k4ZuZGcXL7
 hfcVztnas9l4f6CcK0SdFcSVuG5PoNpkGiQmcZTvrpUoVuEUoQa7U2iBRsoFSASBiEx3EzPqr
 xj9JVHv8ZT7BMfG6AcMvufWSECHAnQCMEXk08QkrsvacABMP9PFNhEFN2dRFrOzUzBjtKkCsa
 KlqzK28yDguDynjxweu5UxtB6rdSPFyfP11waavn2dCzNzU9XZaEDoIt6HMELYX1PUdrgqELq
 F1+PfDrVNSPe+xGOwoGx/AgnZXZUANBmaKb4ko8Vwo3ZYUfM5EHz/Fu+VxLaxv+xifwNv59ii
 +ees+5YEbcE9w/Dy6zaGIZ4MuH9iuUAUumurSQMmGm0t3mifS0G73GWBaqDR/D/XHmh6ShXyF
 3pkPX6bkdAZ8kxEXbBf2NI5N94Ylmwc3c3GJc1/hm5FuSGmjjE2nlYs0mWZ2aasXK/U17HylS
 IToNDiX64p35hINuppT7LCLILeQWocey/D1CKzAp4rDPcdPemh1d8PjbgTAHVKNDJCOeFBP42
 sweu1HvyTwcLNu3MRGhmq8w3H1KkcpjZ4T5Egv+T9aK1DfnMkO3wOE0YwPbO1EkbxUrYjDfTF
 RMIcNEFdDK64mpcXPVHbomo0Ho04N7RfuBaAMScbVj5/9/QqHsy9APZYrezpXk144EwX358+L
 ossofT98ho5Qyc04KpQ768TNJywqVfhF0HXqn8nMll3YVeymIS+KgaVHsDmBTrM5Y8hkmzFBh
 yA8z8LB/FJBFCySo+sPZUPublj6g9PtstmzyngHthIlHoArJDH9TV6D4kSmia0AZ4Ff+aQtz8
 VFSqWz6SOUYTU9nkIwdwrcwK8RPWKTSlvwrvXRWGQ0HUCBgW8

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Montag, 17. August 2026 22:32
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open
up C22 and C45 space in parallel
> ...
> > Until now we never encountered any of these PHYs in scope=20
> > (RTL8218x octa port) outside of the Realtek RTL83xx/RTL93xx=20
> > ecosystem.
>=20
> Is the ID in registers 2 and 2 specific to the RTL83xx/RTL93xx ?  That
> would make thinks simple.

There is no difference in the ID registers of the RTL8218 that
is attached to RTL83xx/RTL93xx or to possible other SOCs.
The RTL8218 series has a lot in common with the lower port
designs (e.g. RTL8211). They are driven by dual QSGMII and
can be attached to any non Realtek SOC.

If upstream rtlgen_read_mmd() is not the proper way then
I must think about it. But that needs to wait a bit ...

Markus

