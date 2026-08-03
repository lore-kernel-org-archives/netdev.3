Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FA73A7F61;
	Mon,  3 Aug 2026 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788742; cv=none; b=nGDNiSWNKs2uwuyEjlMzLAlM0Aw5qLGPbAHEHEj+nYd6oVerfDra8bSrxdKXWalKlJn3YeEp0R6BFZuvY7PoK+ZOMzg4LoM+7oOPYng6ljDhrWI/XUXbUtLXRiVdTKIsdjIhSWVXX30A1bkHWHoUHAgdOPwlW5QUCcFre9+FN98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788742; c=relaxed/simple;
	bh=9+hExYLxlnjPPQSAp4SyQ85rhFbP+Q5Z+vEUS6gTYVQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=XL3TtqX1XTGTIQXyLcl16gNWRakxefIWiCpMc4mqbSig6Dfxpf+tUs1ny0dypXQgVkvz374bg1805ZbBT6IsWhwOynTIjXna8cqr1XeptHmmmN93ZGov2Mq8gNFD6ifh5Sm73/RNODvmnzvh3Bdf7zcgA1ogRHHUFQM6ON8eGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=aXXh/aEE; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="aXXh/aEE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785788736; x=1786393536;
	i=markus.stockhausen@gmx.de;
	bh=pBbScm6eBHoscqVRApVvKnIzufYx3IoQG8HSnGz8zCo=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aXXh/aEEppVpt4hodlUGy0QrtrVeV01UZ5l2VUFBgn4dGuaJNRoy3VBttyEmBOaw
	 rPbjaB6m96ht7dMcS6daCk9XQX+UBiIC5NvqzDKG0NxAD3MpRR8pZ4sickh5ldaay
	 cHZwP2cagtF81lEPCdXyhnV7fPLT4hyArJwKihm7U+ZX0ZiHIXYwMpkF2CxV4nOqO
	 MOtnuJtjJf2GC2bM+XOJKCdA3qwsFrKWDjarLTNy/ieaf/MN4HnO/EcDCzOk0EkmM
	 0xmyyNuonq/vK+oYn/uYQKlA2mcF1JdW4+Qzun9v4YBVI1arzyaCOqpL9aKouznaY
	 pzIrJbWrJZOUKya/PA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3siA-1wzXto0y3s-00t2jf; Mon, 03
 Aug 2026 22:25:36 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<robh@kernel.org>,
	<krzk+dt@kernel.org>,
	<conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>
References: <20260803171853.507506-1-markus.stockhausen@gmx.de> <20260803130725.672120c7@kernel.org>
In-Reply-To: <20260803130725.672120c7@kernel.org>
Subject: AW: [PATCH net-next v12 00/11] net: mdio: realtek-rtl9300: Add RTL83xx support
Date: Mon, 3 Aug 2026 22:25:30 +0200
Message-ID: <02fd01dd2386$3de0dec0$b9a29c40$@gmx.de>
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
Thread-Index: AQK3Hbei3S8h7kSkL6IVVfD7+/tbrgKZJ47NtMQFDaA=
Content-Language: de
X-Provags-ID: V03:K1:qLrT7G0WFCww9a2GQ7BG1K+kYGDQdnczdoK1jPSZrsTUwx76Hhz
 jPC3NnY7mCC/xEK7kN5tPLDIaC53wji+4O333wLupsy4I8yMLAe8KsVVkzITdw7xX44BtrH
 PM0XaytzSjH35JfxHrmK8cBWDAXD2tsxn4m3OBeMUmd+SPZR14dfH4au3VY3jdk8qoEEBV5
 3Vn4BRSV0Fot60WTHyl2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZkKauyi3rz4=;vxdJKyappOEqMj/zF/mig8PesOn
 ULp+xE+kj3WVKKoImTl8bXWOS1WqW3y1y4Owps7y7sR+IhB044TCYw1590L8kDEuggB8I2YjI
 D3UWFZcw6ZzKmNIyhfhlS0muxDZxOIfpZll11Mxw3FQrbUBSIsMtJOCXpI8Zc3Sx9MFf12Wm8
 rxkih35gEvCWi/BMyFnldJ4oMgt1p9HxMSgMO3uIH9CTY89tnnN8Zxqp6uIFKsXaU9EgdwtEM
 nDXh/PTwmlB450Y6VKm7yDGUhhBA1EpayWDktG0vP3WcJPfZoZ6UOJkNeaSzqcEFafdv+w4Sw
 HAXG91uWSbrwxt6ZUOV80WTA7TK8/8xc7vpmH/wpQVezlTqJ4U/v7TSo8kTEO/EbVbvN9e5NT
 F0iskKsxvawUXe33Y341SXHgfquI9If8mE/qWNPdfRNroEokL3WsSjl19TLfMy691OQXJb8mK
 LWXKofYPgb48Fbo2nXRTTW/aJe00ljPLnXR+ZbTAkRChwB38qgzTPxjWMpQKsyze8yy9Xvh9y
 N+cYAU2WYfjjOtScSHbTi0aStgXjGp/kMllZOcyBtyTvja2Csaa2+iIle9GAnTfVX+kWjbp+0
 it5pbEYZpwjA6SLd3/xngVNsoNdheYvxmu84ApH6GjME0pXdPu/oxeIiEcs+V8NigS0Dy04Nj
 iudwndnztHzIWR91QrQghh2YRZjJm9BHfudHfjULrnx/rBOAbzwuS9F7U6gD5/D1P2s7RQdMh
 rZS+flw89T0LJqJ8xesSdrTmVCGsGA8sAdDooBwUkP1EmEYGpLK/NczpZmi/pQeZ1iJZRZT1C
 u5LdFcBNHtoGS1SMBfCdqRG2O05yC70g2TOVUFH1Iy7Hb8y326eRqVHMKBIfB2pTrm7rVUaoL
 dpiid5XFcnXVMXDeNUdh9ijK3xRGpzxHAH8EjB7u3l46nDcEPg0yfpIl1uZN5Xf8EJeidjlGH
 TDJSHRSiWHrwSGcPV1Ge7lb54TSP6we8N+jFX2b8l7VJZzeVaHj1PLUGQnAqywFqtErJJM++u
 Oc1r0zBzzGVPSWM2uuUItHwwKenD/2RSWF22u4UvsXPjPkC/7Mxp24MOy/1+8mIWR+Vo9CRPU
 h3ltR2erpFmtr2siWafOygQGTKSocy0nVcUiBPiYSE6HsmN+QAZNLYdnh6ZdXmTjwkwmgpseT
 pm+2ENJPLoIJdBlRVow0XrW1N/Gpwvwg0fGP07mdLfESyB8lpOcpZZCf0qWBuN/A38jty2Vwi
 MEb4mYMinxBP51bFmRyEXO97a9RjH0ExJ0uWTkh+DWOFeleuOv8XOb0RVBKRoVutM5vYYr0sV
 h43ddTwN5uCQddjR1GKUqc8RYnfSJE3nMD7FG3NtVnAv7mwSnDLWa7m3msJF3G0MFfAWDzgJE
 gHHP0ojk2qRrNq4c0UUcyRxYDO+SInFLd8kVJxQ/N9nX3SH1Nds6d+WpfgB2D1jw+B5MkiWK/
 ZP44klrpmcWzYoKVoptVxSrqt2hZFg7/FQf0fyL1tsAK56JzMQP6sXnDFLw0LMrHDNpojDL/b
 8pTkDm9ZQPmBq6zYjCrTMCxftwLJnSg6hKB3LhHhnado4TrVcp3wJ4HDKxtKeFw9274lq5xW0
 LgmX5iLrQC1MoDMNAWFLVot8VQeD1BFFFOw4pF048EHlSg9waEzkZ96gXeVKnINv/XTAsavQ8
 2OQ1yOIoZ2vWDDg31QiHExbuxDJyqKhmvnX+numYojBJrjmO23aGUOzbg1eRfh0QA9mqrW33h
 YQuwPzETu7a/MADAPvCMFf/YW8nM1GCMnzk17jB+yoQmPwMsu6BmLWjOmCNgvvmeZRufvOJUK
 lRO2bsuXWu3FvzzMlFXJjYopa5OkmaX47Kmnrj8wSAA21yW+2lhvbXmCZ5Y48UuZBlM9yO3zf
 uiUj/P/Ify5T9Uzws7YnpjnYHoilo4pXTScG9T3JHCchI3+6fDL62WgA/fwimyfBvKFmgzeDQ
 /SfGq/fjBCNrYuRKhkDI46IU63ZyM8XY9kKQ49MdsMtA9gFoqxMMQbvXitQmsPps2BMv9cvfG
 ye7VNBwjb55dw9eFXN/fETI4zx/SSnV4epKpkGrVzX50wkAlwoGjUi0QXjmgS6nY58rczYYgb
 Hge+OnrMq7KYawJZGtyvEwGdt5GdgwE3DPUvAoaIDDMKmDbUuN39gKkLh2rjyjtczSYUCFh6k
 3mAQZHYBDBaVlfy5KwcZ4VvL8mDAgxHeUBM24FhVxG6EbILNgZ5ijXcIf0mK3kuQtb+18pEXa
 BHgSBxrzajeIIlyr+i3QrJ1NOeL+VIzS9rvAEjmh8OCufnLm90v3yB+44QIhP7INzxhnJRMhQ
 NcAT3/rZ5v6mFv7GdizG0ykjx92X+aavgUkPC6p6eZ3nZYwKt0wMDX/jyqqMQBgeXyiQ6iwrn
 j/grnsRDwc82ScJMZ0ak/fPuIoqDPQiDwxAQSBq4XkS4/C/iulCJSgVOm+Io3T3GjlwNrC0Sv
 a/cEbYLaX1Zza3ff/kS0meNhWtWP3QaRpEMpL2TKcjpDdagzXTg5H5sSPZjL8fTSQC2ODbeBj
 BHv1NJzEnuCY3HVvfduh11dk/SNKdw2QnQnYzONrHvaDGx3TwDpgBQMgkXhvXbufwVEZ3cmA8
 h82reqCbck9SUOqWBzSUKM2uM2HT97/tW5T9SZ6GxsxyuVYAHPDyh4fsSuBRldUId3h4ZHEQN
 eNvmxzGOfD7QIMo2vmANBkHX69iVB33ecJZOrDsJE38REXZDYAKaRjXsq01Ijq+xEAmoWHrx7
 k/KWo3DWeKIg+ZmauS+1WlU2ElcotqeKcSMbOM3+zAapy1oCuym9stDzVyLw77y/PkV9/srk3
 OQONzWsrHMuppKD0Foh63AYQy8qGFcq9wH1K1LrMP20UI+uKwrCKAaLSUU6XLBHG9+gQaxvOf
 60L/NBGkXEpk9HO6LKsXveVy1hA3BxQfaBRJI23GAcxiPdmK5dKkhsC4NkuhHN949vRjKR2kS
 9M86u7eQr5fGIyZ7U9rgFEFTcJTjNxdwWsj7atkhnGx+pu/KrJ8Xlyn/B5Oak6k4jkCAOylNh
 o7wSWbBoKWWqDHIerdO4HyfYsQYuj2ABs83+ZOY5WAlFqq8QBnpO7b5nm6gPX3FhnodJ18VeG
 Gbtf6vjTk6GGyMap7X4N1PqfdRyARhW2KoxyDW0dL2x6YISKvR0gOXHnRH+kvm7PU4KQ3bMhv
 bEfVvtNlUEEMkooOyb1vUK95Wbaw0kzd/diGneSn90DWVPA+bmzZ+NMvnZ6FdjN1jgCstysfp
 E4/y+4sYlarIf91a6LVaHl4NowU93ydoFnTxQ4eTMzktJqM0GucnEdQwSWw2jyO0L2Hh9+RKL
 9YL8FnHAEfr8Z8fS52cIXubeifhGGtkUaZnOvgiPsEuBe0Ui0zl/Q/1/cELJMOc/X1DWoLMQo
 8AOJor2fy6865cospePV1XKmPAAXfoZgQAK1qiNhmBGr/EYNSmWR3XRdQN5OlCReCpQYdBEhq
 ewcDpAQ5Xp9tAYnMivs1+rjgtHJfXagiyFiOafVeRboeY4z6/UxRQ9NKY7IWMnwvZJcfdZLYs
 71REV1aaAdBKFWxj1NlpvDYaG8nNJi1ews4n571/r8WSpzEZo7OZ4JGP4nbuj19QovPBWWMvU
 8cKbovgbGQg70nJibHb3I1anF000OSDU4NRlUmOf+aqycDQihGRkREAKpJu6T4lEianMIoO8N
 lcouW9gp9wnSSeAo+0i5jUGZ71bicoLziSP/wHME362zmmfUYGJFP1F592dDR9TfzXu8TKJeo
 ktl2sNgTAGveAICInBbYxXwzSYQCXzLHlyt9iJB6epcoeVTL3SZ/TOd7xnTh/0a7yC4qL81du
 LjT17VW7nqr/FlZq48D4rOInwNVtpWueg9eY917fYCQgjHEkox1oiKUY+2HnnoZ+b76jOmZMU
 AhzdnjBbtTCHbSgLdcAPpYsip33wZMffBKLG2GFihbe1l9bOARUzAQV6ZEATirw8tncbRj7fQ
 ajBSW2BgNO2jXll8tXYdvJLtpA3gZhpjbi8GDfx5SpFd7fGZcvYjnHg30UnFhnx+dsXMjuMoC
 gizwaUH5tcpDwAjl+uIguithmze/+qts5xQlU93aQSzxKgMsaW4ZKBvKjsNaFtPeZg1DTuvUE
 LfoLGEzfLbQCViWtuvLcG5jMx/68jmQR+15KsJtjoabP2o/pc2MXIaUrnL9X3tL6X4h8meyIZ
 9SbnJKpUTUHGN4UXgIWDz9Dv5MK6SzActOUMdOGNoCrm+9CfrcbTrcjFArsEH16rBJtEofQfI
 Dxw8eqB0c1besBh2HZNAzEVPnAmOA8sxWm2RB9ygTLuqVyPIde7Sj43wEzMxv9BH54yo/IqoS
 X1j+1LHDYGvnDRG3hCjfNf+L1KB4MN7Lydcth8vMSKl1oR/IHrBebUvYSq/JwMkE21TV6VrFN
 eqQgiy28N0L/TmU+tyY4jcGwt25MAj0htpf1HLY8Ln1Fq1hWYahM70CYa+1jSdetRxG8EqMo4
 XQJkB82s5SWITpg6EHw3ipIojX7EgatgOpmKFi9cG/OivxFfXXHmRmrDKUXhQCD6mNCLFgDiR
 MPMrIXj2uNggW73qS9gGqz1f8b/G+DqwVUjw+SXiS7hIypn6boCtls83iWqN/fhDrOj96D52b
 hw4anuhkQ2FH16pf0cOSIuPONMCnY+BBiGUSiwA3YLt1b0n4HeY5/J1/TTjoe4VMSM2hBrAY8
 9EkAMFisTLrmHVITEH6M0plnASaByrYobmLYXrH4ofItIgmNXQhgdCB5RXzb+S+dUsZf48NyI
 x01wnSw6EXQjgcfwQrmUxksH1aH5UMcUhJ+NJe5JKE12PG9qc1pl0smF5a2khs/q2l8CxNkeg
 GckTw2H+is8daXDsHBr9sGr1IwBs0CRh7r8XIPPYNBqEadTDaKl5U3Cg9W2slX/s4RkXXhz6K
 /a8iEZ9kje51AYeDDo2i4FJSpgL2WGfI5gl4HKEFunvcqT0zqaKgDXf2LvxUBFrdCDhcO5SoM
 1LAq82QC7k/7DUR8+ubFqMI2QcyDzQvPEy3SUVsjA8oZxXG54Z+CgbJmOa03e0UazJ9ZgT7KL
 pJx138tnx/3LYuQ24QdjnzR3USLEQWhWuWyA4yY78JlD8JFFezDtcldq5AjtxL6yqRMG5dX40
 TCzZiUib45zTPW9+029OHWeYSDFNVO8REXxLsZEUTLzr8HMw//cXzbbKO/CCqxFLeRGFR0dYo
 hx/W+Yp7x+3Bla35Na+ju90Dp5IXSSvNw4j2I4UjI8jO4Afw4X676euBSBC25EAxS8QBIEnNs
 dSq8H3HSt/egj3Eza7IXCo5FGXwCKNrP5/tN13UVIYsbq5TFdQFYMj2KP3XLh7erfCRcanlDc
 aYPNMQeiPwWvJC8ZVGxs8qdkyN+e3tbiKLZ36el/p0ZcP6fogdf0MD8zPP3nHU+cxojGGaMQB
 8ney/JTQj6D+SDO8j8IzVq9yHytIWfug9wblzLumoO66vrJy+3DKkqshMkMT/s3LUkFAKBVU/
 uurET7+pgPFlkvW/7eQL6JIfdhbSWvKw0jHxJJ16gVUb9PMckudYF+pnkN4CeVjrEZSjGkARe
 H8+WUxTrVk4x6jVYjaYRmEJBC13gANBl8nYgDHHlMltv45Y9kSenDTiDGUf356luLzsKi+asW
 8k6gDJRC2v4UKCvbPJOTgTLZsZko5RScyIim+otMWl5rZEfad/FZ43yOP3wuW+NzzfYlEE9ft
 8BsYzLMycqPDo3KWOTXsOXKi0hhkokwytGM9jW7s9WnSRx8dgaDHLRZZBiiL8Gt2nS8IUvVmN
 nfYDyUZZ5Zled7H+DyUQvx3ZYnOBeJ47hRGUn42ygwxaiJKIRUnmSfihi29OFoveeeowqKoUT
 kmyRUOUzUsY+MJ4s5i9AX7RmTSnqRu2hqRi6YLRCpLCC8fHd3TNDw5m3IQPL3qXhaScIK72ZN
 H/NqGMqHW4Ia5WZ3ozNLGSqXn0bhceVXfKmxHDSMG3ae/ataLhWIMQ2nWg166t0zS36

Hi Jakub,

> Von: Jakub Kicinski <kuba@kernel.org>=20
> Gesendet: Montag, 3. August 2026 22:07
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next v12 00/11] net: mdio: realtek-rtl9300: Add
RTL83xx support
>
> On Mon,  3 Aug 2026 19:18:42 +0200 Markus Stockhausen wrote:
> > v11 -> v12:
> >   - v11 was sent with the wrong starting commit and with leftovers
> >     from v10. Sorry for that and thanks to Jeremy.
> >   - Allow to support devices that as of now only need C22 read/write
> >     helpers. This avoids to carry around unneeded C45 code for RTL83xx=
.
> >     The feature is implemented with an additional patch. With this=20
> >     drop RTL83xx C45 helpers. (Sashiko)
>
> Markus, the community funds for AI reviews are painfully finite.
> Please do not repost your series more than 2 times a week, especially=20
> if no human even looked at the previous posting.

Thanks for the clarification. After my ping and your AI generated=20
review I got the impression that I have to first solve this with
Sashiko on my own.=20

Markus


