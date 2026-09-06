Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5F6361DA9;
	Sun,  6 Sep 2026 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788682817; cv=none; b=Y/3GyRAd8FSJfF7dDS870O8K64muUMweNaKiy/xSZghh9mzNxFZhmG0e4ASSXesifmycYkDwDD2XoyxOXHjwProKn+4C1qQCIXJ4Y4gbepfWTE1t6XAT18YhkH2PXA27fOUQPTMArCxNHwXdeqbHb3YnL17aUk3bM1ZZDguoALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788682817; c=relaxed/simple;
	bh=twhlLp7PaPiGGT8Wtbq86+OvWR6XdkI3T+9H5aRxb3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ej566BUd8quiIREWGZ4V600+0rOoEdPBNxQFTqWOSJ1fYE2d7rP6Q4g8cpArJXA1fQZNHzWjw8OE7tOKC1NYD8vfC+jhkD89ZMyNu0GJrPQtegw4H+OqrNjTuT/UC6vKCWXNWksuAeVwIlDe4DI0cHHs6uZovfULVx6BB1pIEkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=m3hTcZ/S; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="m3hTcZ/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788682801; x=1789287601;
	i=markus.stockhausen@gmx.de;
	bh=MLQgKXzfTaSioUoPdMyU1KBJpRLEKJQ4X+lVm8mOFOk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m3hTcZ/SDCruZyeysnXOrGB3LsuNH5YFltilmzdjc3/xs0w02sqHdA041qwOm11T
	 VbwzqAxRZ8qg0zUQMfW6Z/6t4HkC7IxsZKPjIm1MM7lZ071m4cXACRLPEI6+VV7vo
	 Gt9wsSPJNfKO0x6715vck2ucYl8XNFaMVnhYzKmzDbljqi9VGNmlSpX5cdEaWIINF
	 ppvDVehJvpPIClO6poLiTUYfqRNGQekuzQv1NBWmG5M2LXHNGTvjbAwreJ79QsUim
	 jZjk4EArRZDFpfM6xjegtfICDHTnh+zcG7RM3YvHKXy9Bi078/+B+Z4Pp/a7pKl75
	 J88M8hNfWgQKTfCHhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1x83m70Rqk-00G3RH; Sun, 06
 Sep 2026 10:20:01 +0200
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
Subject: [PATCH net-next v2 0/3] net: mdio: realtek-rtl9300: add bus frequency handling
Date: Sun,  6 Sep 2026 10:19:43 +0200
Message-ID: <20260906081946.3499898-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Iax/xp7gcx/g9VQ9JPMnTaleAxmP9aE8wmKiB8ozbd6FMC/ZoY
 RWc2/D1ghgi4q1nxmKFX6qPGz/VHtVoJjvZCG12E9CBIHkDsLDb16rjPMBJG0qeeMQAJGOg
 0IuG7MLAREvNSuZfHQ5kgVwQqmJlJ58gOCAU0pprVsQJrxA+DpgN+vrjdb8UjjjY/E75zQ5
 zJdNdmqcQV1dUrgIogbcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bqNtktue0jQ=;wJU9wTW80IOLCEpio2rU4FeHqBL
 TRC490VdalhYqJD+aarg76F77aEgArqWhJqy6ShNAvyqb99h8BEM8Me+G56ZG++DMuzy/jDNb
 pY1scAWBfilcCoQMj0zHypdHatdYtvmSntfPPh04NLAGLc4Okco9PdZFUixFnS2ZnP24CqvUj
 nuTym7EKjBtVl/pKRFTE8QJEcwfpvprWCkveF16gSGEVvXYxaf8FeUqPjAZ15LYuD7y1pFLjN
 u27HU/BRTeOfv9l+GawrW/I1/XPdCoQZxIjTuXugU6//Ey/m9VNbORP4SEngNtS3OBSOkciLw
 SL7p5YnMRY4En1liUoy9wXyQi9itI6WNI+CJiNCHnpX1775Tm8A36WGkAMBViVPVbzcs2X9Za
 ulcXXYygXBBe5mhJbC7ZxnwN+PsH87ySbbyOCsycGJnzhqSLKZ3QP+IrTdZCsXfBTAbbDs3/3
 tWmSXskv8g0ArOcPuWNxCokwddRL0rE4qAr6zDPlTfN7jWbFgt0JEkQhDqhWMien/VgCM+RYQ
 2ct0yV5apZD6JMDb4IDv2gedwsLdWFnYHbvoFtSZzfrFUL9eVloZDTEtSqRwPDGdRZQ3+DYEo
 cUHtrL8tBd4jvKvKF42UtvN7mMpxHbuLPr13lwMsSDl5l1CbmV605He8Zppf9/BSCW1CMVJDq
 tBxTHqufWFnhJACuba+IKuYOpTxYRh7AAmFab0nHNuZJCG9cbMW1QVRGp/bIaGQCwSZh/RRLp
 ThvicxRIBjmfvZAH5408FPNwJsfusxxbjqcfV2nF25BGIBUfUJ9d95r3RG2e1ype5YIy84Lch
 dLT3tYdMA5GVdDQ+x1hdy7Jc3RfKwlwEiuGA0TBPo8Q81yL5Ad+EGyqczNISUAPm7+A3OLAst
 tLMtS5zlH0zrZG+4GpEtvvQ3xmwDOCPQJ6emc76NtevsPVW4RW/uZYyNLow5xvBWZkCDFmw3/
 3fKu9G2THaZk8BbJq5QWpD79CcfjhBB+Qh8ojBaHqqCjYP02s2ZKSomLfMQEXi0WWsSpL+Y4r
 Qwq8uyrWsic7mNvLuOeVzJK5uSesb1poyqtj8LrdK1/RD5wdwLCfAFUIP58sI6meBv0FD1pah
 0JeYOdpHgZjxFX5PebRK/s/8w22XYgeFH6gMKXruEeETSKQcUjtNnFtkeS6tlW3XpBoN4MvxB
 TeKh5ocpuuUKYODJhyiBM8NVqKnw1RhA/W2iOzaxYh5VdVgEpvJdrvDVfxApRJ8FXr2CWcS4b
 fK77TSU92bK+C7ScyoWIp/sFNQQh0qAhcPJvRaEDoMPxcSVC/wUsNyaHQvKL5e/zhPqlnNKtD
 ql24EI0E65V8nhJLfmSRQIb7fyDZQipbCjwHoGGI3R+NeHirDA4/EHfTbVghfnWNN8ugSTcDh
 ujPURJAaObJR+fCD8BUY6US6KzgB0L+G03MhXpySEQE7yHlfC0FnyN0ILMUP0owCJ+L7JMpkZ
 gUVkZSz7LjROdvul19Iu+wdbuqXEGVqlOUY626f+mfWf/WsEcTG5E+umH683RC00Uu6OjmOiw
 M+gzzVI7khztof9A7cfymPu8MufiahH4BzeO8+XkAUE4nCG7fUP+1lsrDoeKAEPu88FZnC9l4
 jG7CZV9/Z4pyW14jnreb/Qtrr/txb/H8lT/lEvPiVXp7Vj2S1FUgGlOi5Kpjwm3lGFEeokoIk
 SL1VBR589W//9SizGRrTaPSHLpJiRwBB969ioqO4hu9/yU9XNUODA6i7OCTADDvzXU4vZ5Inj
 loIo9V8+z32/QdvBWF6w/De5YPwp31g9dq+Dxc6PTqBHYT5YNVfIrRPSxmY69s+NWFQDutU3R
 +0kokeG7U1zJnhSZ3ytNm8iaY4NSWQS6N5rXza0p4PHI90LlzVWsDURhu9Ji2MqTx0r4otxb1
 QJ6xEHj5fYlo59pGZv6I+NpyyGAtZ3d+shkrdELjNfh8s+BV0C1sVgi35vG5352mNhfO1Fawb
 qN0dOTRpJ+lPmhArhFZ1U7NJgRCiF5211PKyRk5yqU0ROYyN9GZ0ty3txvjhhpFXWRjCz2ku2
 /6MgjeXebfQr98Riw4HqGHu64//Eap2NcnN8Q/B6Si5+rBYy8wBwAcD0JEKroQwRiqHa2BHN3
 785wzezLwwx4zPlgyEyg/q5MiCV6+xL0UfeNakbDT7L+RWmGYoGTR9jxa75D62b7w/U/7NRkJ
 EzkOFflGATzX7Sf9C534ikbB3dHdcF5R56vu6zMLPow6gz9K7P4Jwom+svyn8FQsZiPICaJ2R
 QQI1V7Y5qGpqVZdIE8O5EFnpkd51a9wOvZvSfrbMZDyRvMfvkIjLGVL4alV9hO7N4W7qERcRT
 uQoK3eDf8Th3FCXYi8Uk+gnnqbGxKxlNMJPbTAv/kwRWGQe2W4sKRxWDzWf5yQah8afYlvpPF
 IjJon3zPxdHkoNxKWOVQ8/qLC1pzwzqr/BCksbVeK39gcSZktvnQ5eRyieRcg8X8LMWG+MVFK
 SMOzOHwwJ1Lboed3A3JBrWveW6P1/F6AH3HGiiMy/z87J8Yg6f1I9SBibGcLMKmp0w6CiGaQJ
 Myq1nS73UColUXfF9BR8acaGPcD7MEt3QCrdJbAZsS7GCuJJezj27r3DYC2VwoWKdFHzRRjTB
 ZlnVQvkMIFz9fQDQqBUUylL8qp8WzuG8N6OPB2VANLKSXlL7+GDtupFPIrTaSB+VxULL0iV55
 nIKv13vqvWFzc/ptZNjSMAXXRkgCj4uQkbYhDuJnGVnDmYd9FwOvJm+HWrcBafIcHQVsuhFT2
 4j2bBNP+/o9T/kImTDWD3ZRWQaNiegz4p1ShB/9wJO3x1iz1oFpwDKxgKlPN4BmXbR5cYoj1W
 1yFk5+omUu+KU9mFaPHPNy4eFSI0NKf7zkJa1R8wNNH61A56mmkwn8oeTjDpIpa7tLUmf+JQh
 YO+ycbe6TKYmakmmqyk8Fd86Q9gpFyUqC9ImMKhSsaVJ1pnPk4OWWPZPeprqRwozKZC4eEP2H
 +dBbY2+uodpVv5KGhKY71lpTjinkLdC5mG4yMT/9UXtkakgN4ofanYqqsew2HIRtWjP84Ti2m
 mrN2xyrWRcgE6jyG6jzBZGta4uMwexeqBUH5FQN+bc0BqYj3JScNj1fsu72xO/Q8bgr0ylCps
 kwkNOvZ+oMGAaxULyYZMHxHCzSwXwTcdZeea4JlBxClipMyeWKVYhDg0uhS5AnzMvYELYogWj
 09BymCuHNDk0RbmItpJCTyz0UlCCUlEA/KcpsiBqljBPbuWWVT/NiCZXBq07j4gTjMrQwJQap
 huDW3Dlzrgz1rDxLeELDSU4+vcWiICrtx6RXQDOBVSrTu11a1Ytq22+zciQa60Sye3CuZN5PL
 EacqQKSFSVvcA8dHedsxb0fPAQXcGfDyAY9DSpF3zHE0yOOl3qMgvwvpI6ZLfTSi500f08Im0
 8+z2TqLqfvzpFVbVMdsxjpBNycXcvQdAgOkhrbYRbn/Arx75jga2WW0WFr/2Lb35t4j0JiMMK
 O7pgOny324wdo7KCRB83h3lAxpCe0fQ18t3gdrlSFn6J9dXhzLBzjD1dqymqTeMoVdUmN81VU
 7h4b4urCj/ILirPPYyUAKfNu4Pu6ZA7sQ7peB54QfVUtU6MvIjglDfK7QP6Uj/3b0f3C4TXpL
 FbyLark8C8OEotimcWhFyl2XjmCI0A5y3u2v9ZMuoZmEd/cbIp8DaKW1w98ALb3dGYGctrM7B
 +8Jf1pmxszJl+ybqEKXrrb/2BqJsg5pvvXphzwZQ27v3T5+4SvGyr022OaS0R0yycUo77KrQS
 pcqM0fIr64PyUI3JfTK4xNznkbC8CmFEFI4GehZfRNwScO/FVx3aGgQzMT9Zi7hNRRmw6XOii
 IAFRgeGOIunUHxAyGaIerbq7UJ2Ue0gFDh4y0/sfbTlFk7vdv76oNAlilTQR3xyjTTqajS5BL
 2irSnUCE+WqKqkVf86ss8R/tpm7w5sgwPs1bt0zgw3Xx9VEEBwOg3ePSs1WuJe3XwZxL0rFvV
 +GVGOdUXExdfNOmKggQBY7bU1d0OALW5flZrQIHzL3dFrXSEO4L4lnIVkbi0klAfIMRAqOi3F
 wZ5Gb3ZJOmirtKEh1iM4SImU1Wxh5DuMXUFgyG11B7rDrIB8MLatxJcxSerembSnx1otQdyjR
 E3lDajFEscLVDYYpEOvzwpmjXQeLVk4PzYgacD120pIkkpfh9JMtUnzuGDnLgwhC6rO4l+mOg
 KaPGFDkcuk4qSOgpGnAoWSAX9Z6O10FW0c5tihxeYAaSe6qXP/mNsBA5MJSGIXB5hCCekHGJz
 hidSgsoJuYZWOumX6rEh+XXZw/tNt8/ZZ2+kQc6aMR5XoAzokdqilzz1JDbAeVXZmC0Ks4Nxj
 5lE3CYL9I4ay25ke8ZARixjU/+kzSxu3UqSdiLU8B3gYCyFN6JsMWKdOakDm5vvkUk5sCLcG2
 S1dN0NUWm+DYtdutBnJNaGW6HqPfz8VcpAtIjAZJU74rHOJoVp8AEtxpt1wUnRDksXKTWJgtJ
 mWexLJ+R5VurYUSlq+Wd1YD53x8XqpIWfhyPzbCuyJR64OZdvYmWAbh5ADnONZNUGVhX97Xj9
 D0FapqOEq/4GVbl6pmOhBO2AqgssHeK5gGhU7Ns0Xlg98brZoe2HzJ3NhneQRTglqrnWMq99B
 mS4KaOiip+VxG7T+wLptUKcPTjGugcGrE5C4VplR4w7o13DwjtA8KJ0B0LLd9I9CYjnRF7Dq8
 R7TQa6LO894P9Ws563u82gQBzqMJIbAc5COZUzHBADHHZI/ZAdNyB9aNrR/d9G1zdgUlfEpJq
 ikHeLWouEleKOXz5Ca8nk3csOHJgMWwGHbXDYD20Vd7uGxM51Fa4SFyiYxovL3snkCIjC2OCr
 Bti4Jrw3Rh5t/oZS0GghRy0NkWMoiXSHRf5YrDHHUhHppa1SyIAwYpd070sWAvpULvkkNvZPP
 Yi6ACQPC9I5M+qAtCZL5vwqnqZDpm8x56AnztHded7Yt6gTXz6Rz8WMURFwOS/io2SQ8tIX1g
 1XB1L8ljnzcvVWGDPua149uH4dsRJ+6UAuRzcnqXUrHdYQh8OKIaO3YhVzKo3Jau/swynNiYP
 kG5OGRtDgkg47qTop25kAJeVVoZmuRxvPmjyD81U4z3YXT4mJeh4Yy2TVxTJpEUDoYRAPqaeC
 kuqSRkAEtZQd5A57Amq8JfTgDkX0D7UpdPkC5h98xcSrRSIlJITwhs7V6E6+mwPi7ivPojG7v
 rDY2VH+JPBfYDBiGZpqywEcKjl2o7IrLSfS9dE8paLVVW7Xa/4/sjqENyjZzrsdOJgktxW0bE
 26b7Ja92vau5khlBzA6HVDjNEsD3tFjsCi8idKkddlVyavLziyW00cCfPKOwR59H5P4OyF85q
 sV4H8cF5MQx16PHgOwnT0LwTmfdhS7g9gHedpEeISxZRk3fED96TwUpd+qwtN+Cq1vqjWwom/
 XK4EKUkUYSUui89TVrYp9VxcglBwQuYC2fSKnvOExTtjzbvu2W4KNjQU4X9h7pcezUWbvYhkd
 fgMg09CFWqQR4QcGyjf4vQpZHziaXQNqWWgPr9K8WnacwF3FmL1a9zbnqJ4sVLxSKuG5SiCx9
 tsqH9fqCd1CJbOn/xcZ87SC4U0XFW701bojvWdKMCTkzgTBKsNNiiWwZIMfENwPDtUGuIT3GP
 vu2OvIHj6gESRVVsTc4/SdeuZxM5W8fYolBjFRknj318VwNDQcjK7ZoE9Nulacv/hUDnlGCm4
 zlt9lN5N1uzt6CbYfwxtSHrfaJdJYsF+d0NgfEauknk5cyO1+0DKrSVfl8znkyr8ZlMkTw5xQ
 YmMXTthJ1Z8oPVSiSrnja8xS20O3thejuD/yy8cZFiIY8Vbz70PnhqvUocrq649xG+DbiJPzI
 xPNtkACQb/4NjMIsrA5Kgxrk85Ebk3idqRpleO0VIT4vwJGYwfaah4FMuL8kGcukBMsut3KzH
 RUDGL79QwJBfR7pX3ALB5H2XwEiU7O2kpN+02q3QtwdbodkIs7Tw8zQFJhYMgIe3lZWEN0XmC
 xr9373G/sU08UEjiCp70OFrE7ObmVBRziJqtFEaKXg0sR9Vp/c9+cQk1HcdUkcIA66/XfheJn
 9cSLuyx9zKw7MX/FCeJQloCaKgFT/vTznRG5FEfgzn9ohSdHm8Juct5XdxhBSomaB//O+2wem
 svA81EuqA5TuoBXG4rynri20F0cTk0603y6Cg1KCU2zQqG++xoBTM9OoOeGK1OmeC1COh2D5e
 TFAunNQ5mdx3hmKZSNVsnlhpMWjxgPw/wQADxTebL5ZcZLX0StSpc12i2IkLlUOdutFRInIpM
 x7SGDzC/6YZmaLeKwIxmk/36xFfoSsQbRSXWFEgw7URq/aKWvEsn2AuPFJvsjOuVxQUK+jCup
 wNoHKFLgz6+I2G0ecp3tY+Xt8OM9oA0nRNevfE33/s3ryd+EEzJck+2SbkFwwDf6JTpFKn87d
 slx1

The Realtek Otto switch platform consists of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

All of them support changing the bus frequency of their one to four
Ethernet MDIO buses, although the available settings differ between
the series. Extend the driver to support this feature.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--

v1 -> v2:
  - Describe per-device frequencies in devicetree. (Andrew)
  - Add proper per-device frequency checks. (Andrew)
  - Use the initialized parent device for dev_warn(). (Sashiko)
  - Make clear that otto_emdio_probe_one() currently has an
    indentation issue that will be fixed by this series. (Andrew)
  - Throw error if RTL839x devicetree has different speeds set
    for first and second bus.

v1: https://lore.kernel.org/netdev/20260903122119.2638354-1-markus.stockha=
usen@gmx.de/
v1 Sashiko: https://sashiko.dev/#/patchset/20260903122119.2638354-1-markus=
.stockhausen%40gmx.de



Markus Stockhausen (3):
  dt-bindings: net: realtek,rtl9301-mdio: Add clock-frequency
  net: mdio: realtek-rtl9300: Convert "fwnode" left-overs to "of"
  net: mdio: realtek-rtl9300: Support non-default clock frequency

 .../bindings/net/realtek,rtl9301-mdio.yaml    | 40 +++++++++
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 89 +++++++++++++++++--
 2 files changed, 124 insertions(+), 5 deletions(-)

=2D-=20
2.55.0

