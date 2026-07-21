Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EB9435A98;
	Tue, 21 Jul 2026 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664011; cv=none; b=m+3DobwG7CowqmVyp2ZxJiTjkoR4iHARBhf38YaVRpyeU2ikb184ZKP/5WPpe9JFRp8aQp2wINXmQOf1Ud8FeoF2riONUjU4zjt7IKsvLKmqeDjvdLDvOwUOY/hYSjBjaN0zS03gSBBgbvV5tCe8LCrUlaS5V6uaMWAMvtMIkiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664011; c=relaxed/simple;
	bh=JWfIczC6kzOo9MwIy1FGxHCarFZUP+sCdbVS1wYEM0M=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sk5ToufuCoW0qPYSaKmAuhjGD5nXvVskyiE3Vu5dCMXZ+5uIsKBPcDleBSgp060U3YpEBkMp1lfC2LAqCdb9Eh1qN6vv9YglOQUugZOqD1jJ11lfYfKZYbACBj5x98yzAJzhqDOpV6DvieGfoEOPYgIM+/IJXnLq3ILSUXkF+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=cqWDlN7A; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="cqWDlN7A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784664001; x=1785268801;
	i=markus.stockhausen@gmx.de;
	bh=JWfIczC6kzOo9MwIy1FGxHCarFZUP+sCdbVS1wYEM0M=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cqWDlN7AqM7QCK0nOuzHyvhOhonWjZlHFoA/lgUTRkxRLlrSJCNGhwktYK1J44iM
	 pGQWnjQYZVg4MJwNycHX63tRaJIFtYE/vC7PWzfJMG4RTpSqL/T6Q8FXdqZNr0Le4
	 GF4SsZHwrLVp85TT7VPVPORjLcitvMc0FxJct4co50Tqiq592Al74f9i2PimRlIQO
	 LL9GqvO9XPqwkkg9AX6g9TW+Nwta7I/IVf41RNycA+LaXUJHowNLo9RJX2UFQgLGk
	 uEcOSdCbo2W04o3V0aOqooC2SN66vGJHSDuNYDnv4tK5k6oD6tjQKFPdNaeZMj6JJ
	 Zs2jibjt73QDTxzejQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof9P-1xNIHw2Ell-00cgqH; Tue, 21
 Jul 2026 22:00:01 +0200
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
References: <20260709064157.2865063-4-markus.stockhausen@gmx.de> <20260721181549.855625-1-kuba@kernel.org>
In-Reply-To: <20260721181549.855625-1-kuba@kernel.org>
Subject: AW: [PATCH net-next v4 3/8] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Tue, 21 Jul 2026 21:59:54 +0200
Message-ID: <009001dd194b$835acaf0$8a1060d0$@gmx.de>
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
Thread-Index: AQGj0Yp7lH/bIAgQm2ceEXQGLZZ2bQMIxkTxttKr7GA=
Content-Language: de
X-Provags-ID: V03:K1:7CnxM1QDQW4djJ1H35pU3pQtTW5FBtJxMu0XHwcABaRsS48dIY2
 HJD3fEqBXai/ZFNsQtuQMitWlPoX+Ad9P1gO4ANsGeUdylnpClploXnQ94QyqZAB711vrIU
 Pm/u1XJK6PLtEwnvRWVPMdZNNddEBiaQ2v0reidyiJ0GW5MkF4r49Pmy/hZAzBATeu860vi
 m/dk1D9PGwhh0kBICR8DQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kPvw1iqdNTM=;rNtDPfHHc5ib7MXMIvMhCIVM823
 t72RRQ+3B0N5jKhw+mj7WJ8KgwplcYosGjAQUi8HXGZKrQgYfN0mR9QGJdlffMpeu9xj3/3ZX
 UrcmX2iJh7b0qD6hdBH+3lP5jCqbCns0miv2ucpgJcHQAxuEhoZAmpMwqr0h5s5hU+RmW5RAV
 ZAm3CNx9bPP48CfOIulvJSArhohG7GtxftnYbCxEVgaWAhIpJEWT9S0wLoGTnj9qBjj9RomPI
 JHCpiqiuqflHRGx2GBeKZvy9u3kN74I6uJ2eEGH9+wJ65CrFyrd0wYjVhNUVHsZhEC/w1Kmye
 wxHwdhk9q/a+/u3tegjBssQN65uRIy/NAtM3xxxVx/apzRQgGBB71a9fq7locXR3KPiym4hp9
 6usPwE5/njpU6aPB/NRus/lzHWJxytQZzT+hb06USomKP/9fufobmxSfad6pZ2M8ziGX0FyyN
 R9BuOtnNKrcyBQzBb75FxfcSWSdLOpIPEqIuw7rgbkcKxKLftTaNgPH1wZrTit0EOLn7WSUfp
 UZUdIRLwAt8qf38ExEvuyjjDXavYu7xdBmRteH/gxETJn5aP95ZYOLciDMA4y2YFGX/ziKeQ+
 sNr465nD7tED/Oevl72PGtRxp1pFpLQB7XPiby2Qowm1MnLIC+Zr/BctvPy0cdE7q6XH6ChK2
 y6+FM8ztQaWCUbBrug2orzI99MWrOYvoaSCVW+aParcPCwUIPO71jOpWawS/ms0mjg0Pm6rgy
 HYsX1k/f/hdMzTWkQVO9QWV9DlfKUjevJDdragFlDfCCNY5QYQ6z5AVnOa8t6M90Z1RXCTsJw
 t3I5tp2DH7jzhAunG1hVLmWJ9FpUIXFakDfvXwwsBVqXMURJEcZRZ6uAAJFOmx4RFyOPdaXso
 BwbHAXJGF6DSs8BK7sCOU/NFQBOmYW4v7a+1/AfGli1rCOBYWk3NMeCEoXvjxk6Wi+hYwG2lJ
 vKXG8qKgRvlRV4dqyW0+yF33zcoonm88hIZi0VTcbQGDOS5VWbVFT4RSakaWb7JWFZpdjWuK3
 E5SVDmSNXTj3G8eld+3XPXaGmWNH37sbsCrq3CkOuvSjpVOtXUnMMl95m86T6Vvqo/kgiFUeW
 A6Sky9xeGAtg/FRhijBI41JUaP2Um7mwJoxwyBkYF4OM0/GyXIxHWydySfvBJ4oRw/ooGTJ87
 d3GjAGBOfgL0nb39Hhmgxx1wWNRxwCXG9Piw2753erSlQBkT2/z7VddBKo7297b/gRO7Tx9aW
 OXBcfFqd4OH+3boilxAyDHXXXHql+bAmqY0501at2k/EIZopUZ7G3TXwIPyjcEMiIjeXYiAQj
 YSKi8jIf9diOdt4CUr6/Bua5aoMDyK29g1A9A4GpyJbTdkvGab2RYqL/QewkRPtwQw4dnseWz
 ov/i3C9Y0oxnoxxXGyNVwlWs9t9d1u5y7wyzlnVV5mbVaCkfNVWQqTvk5+SlPIEQjhMk28wAA
 4HSjq2iy16/aVfbFFsRrkuKNca+v4uOyLYK0Y8Ahz5OHYFILTWjDi6YUY3vTFsRhK2/CoYI1R
 JiS5tSD8n05TMiS/pKsGUxRV16zTvQiqgnaBnQgPjOTVr9k4LeOcmm9h5aoWReyUVmTOzwt2e
 YR1Iqit8oBkSaunnXUzB+TNFBz/Gbl9DNsC0OQ3s797QdFA1p9Bazs7uq8FMEmIPSFN5SMpk5
 mPbBEKY4rkeZ4sz9Y5aUbtsSNQmaTy6V29Bc7zpxlwJ14rMC2tS8xSpKH7MeyC/vi3EFDOnjl
 BQB82ixq1XdySJCiVMUsAZ14zEFIxCt4gzCiDeixtVj2uXi7K9uiRX59Cq2PAphbkubwZ/3Z5
 +IdCmKN1D8cpF+QC+f3VcAMxLdw8YsELo0UwH2e/VNg9OcKjPOH1LgSdov4aL0GU+wb72lJk2
 khkdi54UYciAsjbyYoo890IazQWY/4u/+Jr4V7kcUasRjjPt917efF06v5YZTtSPY9uEq6JUK
 wTNxjX+BpXV6B4pHxUgZt25NOtOC3KRctmDXHHySS8nGuTHtH2fjGL9g8nX8WO6uMUErJ9I0s
 D8Ry2NJwPw3Lv2VOWTbdxHQTA3IIX6gq1hUL6rRk8aMryGwUGm7GgxPmuublpmOCdByoAVlU9
 Ls88GWItKGWd2ZAlM1WXwni5wQPRquDJX8de7MLRMFoUZa/7XOLTbnmDvHk/qA9MLMEqmwY/e
 hXbxo8qBdee9fOxz/fpD7vrcNibOyYo/5yKJFhKu0aGC2lbd1/nD3GSsc9KzWo/aXysY/Iwd2
 flqra5Lrk7DCTxnqAuslIi42BR7gMo8bf1eZDA4v3NintJDvaY5iiKSPoziRQe//0E9E7ro06
 0AXl8iaUyqUdrBei11Dlt7e+h1jr7ICyLIHrz4MbG6W6P52j456anoN4485zeNk4wrO39zmUM
 mV7Gwkd8bmbnZpc6F7llAt0draE4q/eBgcf6nok5/82EZUoHZzBucZ9E8AlC4WFyD0ZKRHGSr
 YQwJ/oFPo0XyRieZvuAW2ZANCwnVAScbtOYYbe2ZLpDMn3c26A9oMZCSy+gKIcBdI+RpQNZ6T
 Sz57/itWOSXLg52L8AYskLzaTJmSkJlgm3L/XSMPQrG0bbo3zjsHbsxxLWgCmo0W3/+s9Ugq9
 4ar8VqwR2h5S3TsRaBawTEmL7k9ljbRZEyzqLlwZeNRb/Dt60zZnCEItqKZRL6QoEc5BDgAQA
 UTUdJgO6q2u21P0vawDygxM6Kt5vevks8NSgQKGeRHsl1woysp2kkw4sr7XH0OXoxaxpFuxz7
 wstmoZfnZZ4B1yJzsG317x/TDghIZ7QM7iLinFkBtbpnJ9scqze7kOAlKhuLjN4NFsPwtgv34
 E1/FJSFZzMzdkzwrJ2PAdhDqr0TQ60q3jKYXvAHD0dCiAN/ScX7IEH6QJVGinj679BwO6U985
 a/WhhAypPVLeoIMB/rjZogyXHHswMX+lMug40qZ1M+SnIYspbAHyykgoPqF81QXAXOVNVToI5
 ThX1ZOgxkLhMOOpo59DduFrI9HP3kx3tFk43+f2INYIio3/Qu+00uJNRKyTxqeT1cdLXAnxLO
 cT5mTELWyDBPkdyRbec0t7hj0zuwP6Mj4lsrvl0DDnZpGj0px03Mg5cxu9AEvXNGqEsyAWibW
 pzoDloyBfMlj7czxfm2ApHzs08JZCvpgId/eWG1h9ACLKkAwiMghXtlpXSrPg28fjikLJ1EOU
 rXwnjqJp86eLGtVGkc4d2omAD7QL7CCD+F/YranZp8t5ZKB1JVi+qJo5sYvXxxUgKe/2xZnY7
 dqmo22Lc4ENnX7g8YTyMMY5s6MgdKm3ly5i7vX7LP5l60v+rBFszGRLfffXG85GdYUS9Eoqre
 EBI7oQiu08+fn74kanyquAVCUS45IKjlHKbKUUr66g2rGvk+v7yJ4DvtwbWS1t8zOJwPzQfXg
 Nf2XaEsYhTB4ubz5aPwV5zuYlb/RKIqrhBahKs5wnwfljghFJznyUfMJahfkCIu18s7+bFfkY
 aUtXBZ8pCHZPKMRmW0v1gc1D8VUAGxPG6NWnwJ++mAajLClVPfjcMBJhTrjlHPDFa5/EzmJTi
 QvNVt3A4a0/u+b17hFQ8/y6oYiVFMItGNrMZMdQcQhFdMYIP6CI6vV4t59p1P0vAl7gL2D6Hn
 l6CND991YPAD2o8G9JGjKsjC2hbY2mTN6L3h+6h+T4SBFr2FisrFkTUPrhCl+hmnqQB/d/4q3
 QhxVHvyDwFpeySh1SBJ0kYubw17XNJf41eHRoyh2PbGjVOa/oxZFQatN+5++5E7zGcgp9Xk5S
 caErk4/bMN7s2PzgOs+7JVrle3bY7qaWyI+Z1bsrZBi+WbixACk3VSYlQiNWIXNuOkj3Z3tnn
 HBCCPJEJ4LU6QxvE6h61CTxQ3eNqZJqx3Dyg7TQJNtUQJzs4MBw/J4np0tEwPTGoUVOSXmQe3
 65yPpOeBJ7imSh8qGANqgiPsFkVTKWmVm1mrTQYFqCA3Ej/Bm8c6pnsFPsADpG7xDOwjcmAMs
 zB8qw6z8ffm6IZz5El7LrrUF6bgCT5nOHGUJ/lwLTdb2cvUnIngjDc/7nDE/DJEdA/w3waYum
 UFMAyBEcpzuw56AnVVYUMoRbLLarEShWjxkAYljq6ruP4BAjAtF3HOHGPAh7r/xZoTN+rCUj7
 KroH5Tgbz5HPf0n6n2qv6TqTfyM6A0WpBUb/wZKzYvPm8sq86M1Iz5yOnw3RgO1hcPEYZPspq
 /DWpKM0JO7ceG6zB3g3GDEGdR8ytt1BvF+2i+TM/SIRfsfSqlwlEbKGCYsBRmBEixW8WUx6oC
 zdHg7QEvzmtG/IKsYPqC5d+2iMjV7VWzmwd6L2+6XaDIY0BIU781iI0vnI2MADC3FKUQ1sizV
 lkDJiN9kJ4bgbg2c9dIZ+0SESwlYaHV6PalSnsXodUqCCGLSQTZ3+WLoLwH8SGiH4ilKF/8Jj
 QwoOMW9HjD19z3TpZybOFtoNL4IUl9pEh+Yuu1EGNDaZRKF3fUV+9BLnZ9guEUpyHGE2qrQWW
 M6AL8wopyO323mNO6lADhQMGKyNnXWw5bx9MWCx8zO/9/CZHIyf4BdHm/w3dn9hG/cAVyXbZo
 ifh//GlXq8RYWPCNbQviBFGl+YXc5h4aCY+o0EXAXM1MfkGGczrH/0Gww3UZgKmYzXbaWH9aA
 Duz7dBpohIBhl/Hm43p0Z7McVGHbP+8I1gqhhOd8hqZ5CKar7vYZ1eqPduOqSvQZ5lHDWauFR
 qkNPLPta+27M4yqtLoak4G3U2nwYhtOLOD7CCtpmaKZNE9NcxJKQWslvPAYIHIKrUNfMtXqlR
 7QClaj/oU/5pTCI4Q1GEqcM1YUNBuFUqjOrvoJ1CVJSoGg+szP54zU2OUfkG7dzGnvFFarcVv
 yp/JzJ4H1ctTRQWcgIQNc5GJB7l0hH2fQv0mOXfiBhGRPfqY3EaANbCcH7dzjhHF4Mpk0xQl4
 l8WvTCYnJfdPj64yIKr8Q4vgxuGYuqaGg65QN+/4Chfd7KO1dBjg1QYaR4ojBAlhP74uhgRCl
 0BHzsDUBrGT1kUtvOD+j/+NZ0cEqDknfvm4iuDx1goFxA6iEGL3fGqHUL7fSMzizm/vEeRwsf
 4v46stsfHmo5oKkN0y03sNC0zvi5aHlWL3Vy3IDOIrTX4s0T6rmP5fnMGI6PTp/UWHSOn8QaY
 BXcDEkGBIcmRVw60mmFb4EVHtZbdFS/qNkPnEcNcdi1L2RHIyrwDNGwPjF8b0fBilnQycTTox
 mc74PoplDww1ZIPXBIRDiKIXwtVnUha5wg/hVablZ22CbXZu0udKtAmq4RFu+pnEA/cJOBTgs
 bQoNQBxNADd5GUprp0F5F0yLAlNXdiCSkonpQ33mABVzNArCnjYkqpGtDQFsEJlxSa+axnfd2
 f8SnTl7onVCDpMZF/vexjAKgqdWZFLbO6alAMBUiMVGL4ve3J9vAAp9Vxa94N4r9iF3FyrxeO
 fQigdkXfIOKSJfHqHgpoIILi/IzSf4dM+rud7asE9Ztf9UWDkrlECT8ra9Om4f7h+LzcWbLGI
 QN075qdxVzu+X+tfZeyasmKsxf0jJ+Gkz8pDyaZQxtwC1hDL1syPfVBgbKjKyIQ8JWIHTqI0G
 JqDMSI2j78KzzfjvY0g5pLUI7Oq3ms+tdQUW2Ysiwokayr7tj7tcsdJVYSe3tqWk8fVkTmhDY
 O5UgXl5x5BzIq/dz3NQ6/0jGgFqcTfOZN7vRz2oqrF+CsCfDVQJ6hSilEOgK5yiTlyQYgj5SB
 j8hKT4BqXMDkJwNEc4Tu0ctUnn/W1nb5jhPhvMCviXBpkTSZ/7H0RpiMONzdv2MKcLvfpweFO
 UgQ135WMcoE2a1erNy201dH4o8cLyb05Qy2bckorRre4TQKIMZ1IJk5Sgyjvz9cM=

HI Jakub,

>Von: Jakub Kicinski <kuba@kernel.org>=20
>Gesendet: Dienstag, 21. Juli 2026 20:16
>An: markus.stockhausen@gmx.de
>Betreff: Re: [PATCH net-next v4 3/8] net: phy: add
(*notify_phy_attach/detach)() hooks to struct mii_bus
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
> ...
> [Medium]
> Is the pairing between notify_phy_attach and notify_phy_detach
> symmetric on all failure paths?

thanks for the check. I already asked for guidance on this [1]
but got no feedback yet. Maybe someone can assist what is
the best way to make these calls symmetrical.

Markus

[1] https://lore.kernel.org/netdev/008601dd0d6d$f3b143e0$db13cba0$@gmx.de/

