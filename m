Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECD8374186;
	Wed, 22 Jul 2026 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701482; cv=none; b=E/ddE0q+KWDFrp0LYRY5EkG31z6UG67i6XwWaSwF54AUL1JVAQBZazJgUAEn8PXAB4htGBI0IhV7ZLxvgl0qAwVP0esVO+pm+kb5LjnFUILoaJLomGItPanBAQpBrQ0qGPKJ4iqcIYAtcwhaQUECZan9UmcsoaISOtwg+L4uC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701482; c=relaxed/simple;
	bh=GmHD0eOUXcUtcIUtNyTADj245c9Pq1SgURUFHVZSxZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmHtFsPxVOYuzTG9mp6Xl+GNuG1QS1ZqkXjczvuik6cKAcEnxeFhjSW4nFoY9HiWNadlZfN7+k5xpwnZDID1EQAnSXDGMolA7d1ecY7dPpg56PrJ54TUXNMXIW3MoOzE2rqaXZ4aP5LTKYqDenDJZv7VFwXrZl3LNwfW552jN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ufDehRKc; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="ufDehRKc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784701450; x=1785306250;
	i=markus.stockhausen@gmx.de;
	bh=fFoZCPISqAQDKI70R/ZP9SK4ujctBUww8L27LoWZGqU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ufDehRKcg0dOdgz7+/efJmBLoSp0MTt/LZgZanUcACmBFp7bLdSqK+InlZNSyFFl
	 q9tf3U4lNMSEsnxMEt5b8AHmAc8MMoAd+WMkpFn5pfJT6rk+XY2AyFTiCRxKLCJjm
	 GKVEpoGAtH5pKJxAxljrBGRMqY/enVKGJ+pdFL0SzVvgtHOftfGV3fGmd7R1j65fe
	 L7bV6x/rrx3J9lR/rfY0B9lJyCT21nKPeCdz+2SMW8z19PmokJNOc65Wr+fj8rMC4
	 FaQc9bhD8xNOxSRqQl7WgkE5YqHYNWWl5tyoWYzrZpoGYTEcCQ/mGNt4wIPo8q57/
	 gJkyFENZifgGfYTvkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRVb-1wTNAH2JgJ-00WoqL; Wed, 22
 Jul 2026 08:24:10 +0200
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
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v5 8/8] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Wed, 22 Jul 2026 08:23:56 +0200
Message-ID: <20260722062356.12291-9-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722062356.12291-1-markus.stockhausen@gmx.de>
References: <20260722062356.12291-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GxUFaVkKrRbfimlFbi1Y9LNr47HaFIVDZcZJUQyMx1oKht/RKXV
 RxiBFqfB25/HP2AFN2Od+EYIBT2UqNXtDejytm2c6PYhwm18RwPy76ezFIFwvp+GOeDj9e9
 IG/XsVttDuE3ceN3ELZBhzmX8CkCbeIbfTGRvW+Bbo64Ga0p2X2/Th6StwEw+hBFktviWJq
 EhLkx1krs69EgKT/MEUvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MO7vDmpQULU=;ATck8+9Sj6j0eiE9e7DynElAtIb
 ShqC30IIORtirHMX6HJAGuShkMRqHbfeU/x1bu9tRm7BabEK2mD8m3x69bcxyDAxEaLHugCSQ
 iDfIjH5HARJpiFAuPODcqlP+yxPrWYmaozViPNU1K3lELOUvBINBAwQKMXfeYQ1Ya6oLJUiYi
 7ow/2H3/2RrtNHpWPsQzWQKBTAINLI79LoDRgTZi3z8FoJzq6aAXfaARDGNcTNxnEfMJyDuwP
 65QsBXNCKIJSU22SZP8F+Wv/IbmK6LrWFks9sL10UrrU2pVAWtetDrj/+XfGGi0AxmCiP/N1m
 ChRHVJYXjTcB3ZelSYEJBw6belpgw7nJOmSUSdcF5fPMbbSDuzKVUmAdWJzJkdibHomPBbeuA
 tN8SwqC3y4qwmACwmHx7UU8uLVTcSnK2OF62YPLNebnWd4FYQrkmgyHrcmD8SooCwAzNQoJuZ
 sMAVPzC60R5TfQxPODpQZz1obXLRptPVz02iNQHvhoFD2a40BnU+WCV6lMwhJ0cZA4te9Mt5j
 yuB0x41NOYFWkSBiwmKJb/gFx9oDMTDbkUCFe4vdhFFnBw3lUVCD2lVggTgiWtzkDWrdmBr68
 WWth74rjAMYCPCaNzVxQhYl5S0KTaZFF1iMWIIF1KFVSKUP5m97EzGbktOugNEIfLVja9/Kr9
 98LorkNxpCbAwtsZ8u8wSh/mjKo77GLaSKDUa4RMzqqwhR8kSnyg8w/KX6HsVeDTXd4sNMO8m
 yR+7WeBqP/xOlydu40dAvxQZVtMBx5rX6rS/w2LsFvVYCGdxbu+6fPJpCKCQcWpjqiuKA/rsv
 J9eJrobsW5XU3+DBCdCBhSRwfWMss5y6uAiUh/rnN4MVAmQwvO1Ue6FdQgkLzNtePUQNqPrFc
 cx4FuZtUsN6SsPn4N8SF7hy+bn4wnF1S0TEXh59acu9cc5JcKYZfDPG5bDvlXBtfx8FMw3qTY
 +NYX9mNG+5fIZt0aGGYxo/oZ/xbRzNKLUQJ62OKx+hdZWyr57qFFRzxjcrayROgj7yesmMLqz
 mgQJjMkGSyGt2mrY+StRM3wWuQ8LqCtO59EcKFPdlZDcNdsFtZWcEF9TInsN7MYIvI33M75a9
 KZR+snjUySf/0vhbh8eRfZSl4anfcPrDukG0iLhSc/eU3Sjx9pV32dEX5H8EuzKJtjW0Hy7yf
 wwDsHZazUQUVggrXnsC1QaUglv/DJwboZpNrKVtBLOQUqU8KrI+nmf0yXu2B1HtRTJmwTBEv0
 rQCjiBgpeGesJKJlPdQC8sF1pTxffffIm0z+uCXDV9LZO6wPku/A88hAADPmd1FRgKlKB62um
 iCC5FNmORZjW2RItZ/qoyc6nIC9U0KnFXVwF/3vD3zsctZngcQBRbS9mRNlsM4HJO0ufGiDZV
 ktYHICEFlmbdWFCRmzhep1EgEC2uH3qJz7y6Cdfrx92GcKaMPMJTrnJArZ8s7EtpySCa0I7+o
 srH4YXgj6ty82/Nt+Y4utmJQUCSh8rNFANiUqg9jJyCV/Badjarms5jmad4pOVx6hUpsb6lzE
 thB1nDtwqETiYKYqFDPhBhRck9ggaEjDGB0FjMp36HRli1Vvsd9+P8W7Lzm2BpSyr6OxXGDGr
 blcAsDy7+8bLbfHq/b9X7ZrlFYXesFUjKNmsAzX45CGsaFLaJi1C0ETD9XhH9sL9M9Z2faDf7
 xrV2LckDrREIyUiLv5wL7CK0Z8iqiV1HqoMqksxQS3AF3XfDbc0HbuDgHklEfSLKHApdTC0XH
 vWKZehFihhtNIo3ZOpzGsWa4fRhNlvUobuYbKp2/+5FxvTsr7ha6wLu+8p67iFoNQREMHp+BI
 BbVkyAap/9B0VRWHX8im9L9/qKvyAhRvl9XDCdR3KEaKb7S1fju6pK7D4hr4hCPSABjxtNFZm
 fTIwBb6jyDOu5dJTzZsywyX8Had8xwCb2KgaZvROLneVu2jNuYIaZ3vM0KJZ5g1U5ci0/jPDX
 u9L27HksOj0QuW3LU4J9ihxTpAkIFm6e/8CuzWCfUBaJ0yzuZL7yPW6HZDoZNCK2EKMkGOZ2l
 r9U26D8CKcoeNIDEJTfCo+m3H6ie8i5TYiApG6dxftFlSn16gqxOeVJg6mXhjGxdSOXLAB0em
 o46HPVAWTv+sA2TxOccefUdysG06THLOBKDu68ryk5Unhx3FQvbWeka6U2fBhbEZbtkL/0145
 NHEHWbKYYMjJD3xDQt72eIDZJSdKhZbKovmBbThRQn8Ftbx7kQ11pU4cWKXdmkw8TelDP99eI
 Q41+dcbD8AmDh10ZhavM0HRIZyAJymMCdJoj/VL7MHQ67ZgPv0IARKxAHqkDIpVAvGe4D2xRi
 /isFz1PcOKB7JzaX6kE6m1Vw6/f6517DPdwoQgATlYHKttAU4AtvgXEAAlnQOHgE8l5miuojJ
 g/JMoNqTx/ZLcQQ7FSk/x7mxWGMjgRUYoze8cFDJT19LRPntmkUrT7lFLB29F8Dv7egtraxtK
 2aNLdD7i9UouNp5WhVCe+OSM9bQn6CpLGMn+ROpszpvmWbonn5JB/NOVC6ZK0YM6F99RQuZL9
 DVEp7272/a1AjX/KISWYcF9Fn1DW2EBRcZ3DKYRuS9QhxfuBdUoCsnQjMc/iVystUgQrjtjPD
 ZgXJPaz7fbAup1NBxWcA/PpdfJfF675KYKJNRIIYDIrTrVLrrCjNJRZmPmZfHZO8rfpzekHLU
 fVZFM6LG01uFw3pSLw8tjdzu7KEc7oZzspQbd+hssGNGmtCybcIAtbRp9ldNiISJ8qdty+Q1z
 Wtj0GAjO2HBFlXe+mLRwxiCEvlauq/OuN8SmJwHB4s2qZtNtGR1ekIxmb6EpdwNrQXMk+3KfS
 CTRFZtPN8F5YN7rBsTl8g4h0UxiepHoZuaHT3RBxdOQR0wCCvEiHDGfJGXEqxyeWzzILQPqEv
 FcP5LpOrzr5Hfh+B13WVomDlqRuZM2B/1o6sxj8mxZU5pFDwHtgCm74jIooI3prdOGrdAQc3A
 6qhMOatxT3p4a/imjgWsRZNEV79moM6dkDKkv6ec/NdSTi/PtTuo9b2Rae4v1qc6V54GjJqaQ
 vLWNuyh6XaOfJSxiKpYyshhToBjatgRGXg6JM2qvo6N5xbLW1fNxTWaQvOOLFn0nTG+VnLzwk
 r4tjT8DoMHKDjeCLpLRjD4NLUlcNjVBVmKd2Dhr6lt8jMl+kpbi/B6FuWDwmXLFF8m8GVZN6f
 hheb0otSYnoQzceWEpmc7T/I1/5TlfECG0iR1nJ3yqwe3Utx7SX5q07JeN5qovqEVcVybVHLL
 /kEtpAPk90szzf9Bo1J4Alz1d5ZEoaoj8z/4xBJdcHjBPKMOJ+g7k26YEJMD3vX4cPYsdn4YN
 YylJhKD10MEqvzJOw0phmAEbhDE83eCD/xde3NRbJ3nQV5t0eIRrw1VfnE6Y2joWH5MFt308o
 7csvYYLEIKgr2vJu4SoGEroPmC1P40nHmHedrSdULiuDgkZYNDvClox8T9GHJGfsHnAu3bIdH
 SoUdI4avxIHgKwcRlG8SpK4FaVCcjA7yTxfmHATq0nsw0TijSwumtq54brhRsmNe15OqNUc+e
 iTPrCRu1naB4n4nyl1jtFCkFqGV8nTr6wChUfI+ySPKICFxPlgYRpSnZP52Pd4yN6Mg2qGGCy
 BqSYlFwIuNjSiJJTME0S0SIwAHioVdlszZt/gIelJk08QRzAFXL27vcQUZY4RvaTqy4WwFbBB
 ZfQzxUxhQmJNCLvt+M0cmMM+HLhgiKonxD+VPD7KXpvYY3BPo95yHQIrTKofo0TkHfvElLvmR
 OTRG1j/I9jFAANjV5fQDfHcNWK21uHeixGxFN0ymKr8P+i3eRjp5XuSPW6l2Qw2WuXHv6Rn2B
 pdFdzqwCGPBeGCMrDffzPkv/eNs55zUJLyiaQxiSrXeva8cHL3LnFBPCCEX9s0+OO/q9/Kfcs
 wx6tnzLq8lX8kljrWz/WrMDKc/M5+uASn5NIChuSDmRCb6Wp1chrPZcc3qUhFyIttI+iOm/JF
 RoZe1Mz7BGjGZAI2EJ/3xF2knYX/s3QeUtLo48PJ2EoZEV5le7H+ZRHcRY0OeWDIYiaLgFM6v
 /J4FzQXwTet0pRGpw6WcF57dD0XNkFuM+ixXgcXIdp3hNzS8VFQgsrYIYfVSEEMot0Xa+AfuX
 ikSoWlvCrasSa9tT75agmjOH0RL2erfWlspVBEAMhnX2f8d4faweKMHjyvzkKZo1QeggKDJ7y
 tcWuM/qCTiLgjj1gEYEPYCEtPjSUeSsWaVmpD+u5kaWsuwizfItOqpm0FtWKr/rALRFObxR9u
 B95vSvxfA9loGCiXjT8mdL6Nx8o7ekFgkHoZNvgz0D3GdRfnL6sfgjQxSqTI2T9fNlQkU2T02
 I5IjeuHgobl5RwxLBpplYi9U/VvqxcnDGWzY55qRVeeUx1pVMGvqLzONoX8ZyDAUn/kFFZ19J
 xp2UAj0gAj6EvjKdHJw4C1KHuntqaSxfT5hTbQdtJ06x30VcYcO6ugBjcFhNdxpIdCRqLObZX
 eniUQcZ1wwrN51AWFqA5KEoMIq0LrBuSEdKHnWMPPfkP1APEYO1eFySsoxiEQflQzd0LCJyOf
 vO+pzcICXUoex5oK1JWz8oJtmJEbujYztOQYfpB5RfY4QjVDjyCq9GBXQx8wnKG1aVRWcxuLg
 bGllqKhhC+Vw31ArWI5XL2FuQ0O07NUbQtPJh1SFGCRguhW7R7RdSqeuhBcryL2yADbSgNjgn
 /VSrPrd+DUJl2y8v2Zjt61jjgbVW31laUkFADQ38yjCpZPlg4HpLO7LgtfKcpO4BW6s71ira+
 vBAlnkFK6Mx7e+jNjYtLhVIh4EgU7Yq/Vg51zNcnCPP4FacscpwXkWxjfmgsAgU/JOlBdtG0g
 cqanmd/9E6fxW9oZZDvwDvOnwLHg7GeYHl5ciFUXS8zcUgSxqlAVwgMmX/gZwwJ17DLzYAtm4
 BL9c0CzOJUbd46dRI3uZpMT7vni4YGz897jFcD+P+v7SWOJ50PBqsv/1Ff7WGYToAJf1tqM4K
 EXq+xXlizdkKL2106MLROeiCqx6vWb0Dsib0x4VsK2+VFdPlCge0aQ7pxeGMgxe2XA94fJbaC
 pFYDOoK0nRPx/fyvJ1tXzVyrsF3fE+vGVKckU4HPDltAGo2UIw8IqKl1wnJYuEFAXQtzXsOrk
 k+HwvUgr2OSlnVHHZrhfOWaIov63rCwDiO8WYnOSCC9X9UyAjk+SVwmsIJzxAamrRErtxYHgV
 63bWBe4Nur18Ydu8o7CdcmjALJ6p4ZRZ0ue76k9Ztwsm3MWI7fAAuCXknVE1tHPCQ6uE/9XAL
 xiHLpnfQ5/Oy5jlkX8HeiRnxugtC8Zjty1zFoHKfOj7TMugNbqQLIKhwmXB3pl/O9+giSN1KS
 ylInhIeF7iR1Z8lhMJsj0173s9XpKmK+CUrLAbGFoyoDtMy06HHzPtBByBYs7oK9/8V6Z1vdE
 Yq50gQOOs2SWN2bxnLkDI8CYIhOpyHWzF3oLb7Bj/mr0Z/2pHMM4zXmuSPBi/kOdSboJ8DLM1
 VwipmFPxOUktNXNkMLxGVuzis5+IFZQ9duFUIJE0BjECmA/niZJBsIYdI+BCkDkFrJ6cmBdLa
 ZbvghEIuR+TQCspSJW6MIt+Ks3sLWPqMrkIn5nGqVjGqTpv+53oLwgkQSoDpOHwjyTgLCruxm
 b0eE3GhUDBeFYK4NxPzBE0ywqCWdDkQuVio3Uy5k1S0lDacwjHvERQ3b4qImuFhCJOASuQSBn
 nJk5UyXHkCliJLnfo/V9fzw4WUskbiIwDiqBxuS3+Bz5RtNih9weJ1WG/IEvAXJkSsABjRKw1
 j42KKguigzkXV/5lluZjw

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL839x (aka cypress) series. This is straightforwar=
d
but some things are worth mentioning.

- The device has a lot in common with the RTL931x series. 8192 (Realtek)
  pages and 7 MMIO registers
- There are two SMI buses for 1G PHYs. Neither the bus nor address map
  registers exist.
- The hardware has not much to configure. So the setup_controller()
  function is not needed.
- c22 read/write functions must be called with PARK_PAGE =3D 0. Keep code
  clean and avoid setting it to zero, matching the behavior of the RTL9310
  logic.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 102 ++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index efea57b678ca..aebc76ae5e56 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -140,6 +140,28 @@
 #define RTL8380_SMI_POLL_CTRL			0xa17c
 #define RTL8380_SMI_PORT0_5_ADDR_CTRL		0xa1c8
=20
+#define RTL8390_NUM_BUSES			2
+#define RTL8390_NUM_PAGES			8192
+#define RTL8390_NUM_PORTS			52
+#define RTL8390_BCAST_PHYID_CTRL		0x03ec
+#define RTL8390_PHYREG_ACCESS_CTRL		0x03dc
+#define   RTL8390_PHY_CTRL_REG_ADDR		GENMASK(9, 5)
+#define   RTL8390_PHY_CTRL_MAIN_PAGE		GENMASK(22, 10)
+#define   RTL8390_PHY_CTRL_FAIL			BIT(1)
+#define   RTL8390_PHY_CTRL_WRITE		BIT(3)
+#define   RTL8390_PHY_CTRL_READ			0
+#define   RTL8390_PHY_CTRL_TYPE_C45		BIT(2)
+#define   RTL8390_PHY_CTRL_TYPE_C22		0
+#define RTL8390_PHYREG_CTRL			0x03e0
+#define   RTL8390_PHY_CTRL_EXT_PAGE		GENMASK(8, 0)
+#define RTL8390_PHYREG_DATA_CTRL		0x03f0
+#define   RTL8390_PHY_CTRL_INDATA		GENMASK(31, 16)
+#define   RTL8390_PHY_CTRL_DATA			GENMASK(15, 0)
+#define RTL8390_PHYREG_MMD_CTRL			0x03f4
+#define RTL8390_PHYREG_PORT_CTRL_LOW		0x03e4
+#define RTL8390_PHYREG_PORT_CTRL_HIGH		0x03e8
+#define RTL8390_SMI_PORT_POLLING_CTRL		0x03fc
+
 #define RTL9300_NUM_BUSES			4
 #define RTL9300_NUM_PAGES			4096
 #define RTL9300_NUM_PORTS			28
@@ -422,6 +444,62 @@ static int otto_emdio_8380_write_c45(struct mii_bus *=
bus, int port,
 	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C45, &cmd_data);
 }
=20
+static int otto_emdio_8390_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8390_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.ext_page	=3D FIELD_PREP(RTL8390_PHY_CTRL_EXT_PAGE, 0x1ff),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8390_PHY_CTRL_TYPE_C22, &cmd_data,
+				   RTL8390_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8390_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8390_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.ext_page	=3D FIELD_PREP(RTL8390_PHY_CTRL_EXT_PAGE, 0x1ff),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, value),
+		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
+		.port_mask_low	=3D (u32)(BIT_ULL(port)),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8390_PHY_CTRL_TYPE_C22, &cmd_data);
+}
+
+static int otto_emdio_8390_read_c45(struct mii_bus *bus, int port,
+				    int dev_addr, int regnum, u32 *value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8390_PHY_CTRL_TYPE_C45, &cmd_data,
+				   RTL8390_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8390_write_c45(struct mii_bus *bus, int port,
+				     int dev_addr, int regnum, u16 value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, value),
+		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
+		.port_mask_low	=3D (u32)(BIT_ULL(port)),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8390_PHY_CTRL_TYPE_C45, &cmd_data);
+}
+
 static int otto_emdio_9300_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
@@ -968,6 +1046,29 @@ static const struct otto_emdio_info otto_emdio_8380_=
info =3D {
 	.write_c45 =3D otto_emdio_8380_write_c45,
 };
=20
+static const struct otto_emdio_info otto_emdio_8390_info =3D {
+	.cmd_fail =3D RTL8390_PHY_CTRL_FAIL,
+	.cmd_read =3D RTL8390_PHY_CTRL_READ,
+	.cmd_write =3D RTL8390_PHY_CTRL_WRITE,
+	.cmd_regs =3D {
+		.broadcast =3D RTL8390_BCAST_PHYID_CTRL,
+		.c22_data =3D RTL8390_PHYREG_ACCESS_CTRL,
+		.c45_data =3D RTL8390_PHYREG_MMD_CTRL,
+		.ext_page =3D RTL8390_PHYREG_CTRL,
+		.io_data =3D RTL8390_PHYREG_DATA_CTRL,
+		.port_mask_low =3D RTL8390_PHYREG_PORT_CTRL_LOW,
+		.port_mask_high =3D RTL8390_PHYREG_PORT_CTRL_HIGH,
+	},
+	.num_buses =3D RTL8390_NUM_BUSES,
+	.num_pages =3D RTL8390_NUM_PAGES,
+	.num_ports =3D RTL8390_NUM_PORTS,
+	.poll_ctrl =3D RTL8390_SMI_PORT_POLLING_CTRL,
+	.read_c22 =3D otto_emdio_8390_read_c22,
+	.read_c45 =3D otto_emdio_8390_read_c45,
+	.write_c22 =3D otto_emdio_8390_write_c22,
+	.write_c45 =3D otto_emdio_8390_write_c45,
+};
+
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.addr_map_base =3D RTL9300_SMI_PORT0_5_ADDR_CTRL,
 	.bus_map_base =3D RTL9300_SMI_PORT0_15_POLLING_SEL,
@@ -1019,6 +1120,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
info =3D {
=20
 static const struct of_device_id otto_emdio_ids[] =3D {
 	{ .compatible =3D "realtek,rtl8380-mdio", .data =3D &otto_emdio_8380_inf=
o },
+	{ .compatible =3D "realtek,rtl8391-mdio", .data =3D &otto_emdio_8390_inf=
o },
 	{ .compatible =3D "realtek,rtl9301-mdio", .data =3D &otto_emdio_9300_inf=
o },
 	{ .compatible =3D "realtek,rtl9311-mdio", .data =3D &otto_emdio_9310_inf=
o },
 	{}
=2D-=20
2.55.0

