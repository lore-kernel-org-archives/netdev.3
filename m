Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CBD42980D;
	Wed, 29 Jul 2026 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340985; cv=none; b=ZINkDHPwWkVuPFxdjYuxA979uTRyYjF/rQ5Vn1nb9r+hIKVRV601srgB5NG6MHJZJdc1zWpOXWjoV/69SFxCuUH2kKlUZJf80pUchwC35krcokPSll0JH+K3qz4pdFSSnjQPkDFRVXBK9Oe2bbaX+ula4jkjQzghWSd5uc/cRig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340985; c=relaxed/simple;
	bh=90QkMpi+2/JHlW8+O2FT8jWuoZwB9C+w5AZkxhDPlyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUfrPZ8MYkILy414Ft9dIErq7eqYlcuoXyWFgqPLZ9jAmlcYzmk5ZNsrbQlqJGiFrBWDoEprz6lS+keWGHqETltue3yUYZuTRS4A/RbAar9cqdeNvJP5weMTfCQuWDLazgOHJAhU6p2ezxa5Zb8mtI3v6GC4sK3YSNgMK8tMvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Sh/WDTzy; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Sh/WDTzy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785340965; x=1785945765;
	i=markus.stockhausen@gmx.de;
	bh=oJF5MvpNOR9xoFhX9Rn30mXfBhG4duCOVnBhgdJAAc0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Sh/WDTzyeNGKOx8y5EHGrB2bTzu0vbL6XMjeFvmu716G7wCzmTC3yVZDnW3SbNa4
	 WrVYJeqPd+jgP0VAiDmTMS8xTdj1Lep5rborgd3YId84SYpOR7tgDqTcqTiuGEOL+
	 77OPUxnDpI05v6vOres0+2Tf8E9VRQYua8F1ii2BQIQicCMVQTzJzUsPX80bDpHVo
	 bHGaPF6FUfNklj+fmjaXWqY8e+ocatdvBZncxVGIs+iznbVGJQHmrWIASDU0vRkj0
	 mMksr9m5wjFqXJ2wJ2dUHGOmuQTYALLmga2HfPi5iUrnhaxM3vqmdMXBw3joYsAFP
	 U2yFDXHhsxPtiYx3dA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXhA-1wbRmJ2ZBi-00XiIz; Wed, 29
 Jul 2026 18:02:45 +0200
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
Subject: [PATCH net-next v8 2/9] net: mdio: realtek-rtl9300: Add polling documentation
Date: Wed, 29 Jul 2026 18:02:20 +0200
Message-ID: <20260729160227.155613-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729160227.155613-1-markus.stockhausen@gmx.de>
References: <20260729160227.155613-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:seesJpRHLI7rKOHycW9xQJkQgBWE7qzZO47LguvXtjW8OmDDb8B
 CZaIQ5dmgKz/svNovqi3LJ9IrmT4RJ+UPwZBMmTB4FKPoVbmWs3UKcjaXyrxUFdEiev52g1
 /wjPEzlDZo5afqrj0HoN/kGfA2FMbUqcKVFtSPy/1nyE3WQe6K/x7Cf+j4LJGjfr8v+KOyb
 SWH8cYeJ6FtuAkUfzgetw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4r0iTILBHgY=;y7u7+b7DRwQeRYuo8gBUwpucRaK
 6uuFd6pJFgXnvFv+4azjXeaJhultb73EJmZjTr645Dhvj+4T8f+WGVHmGDyt+fvXuW+7Zkdgk
 FG1GU3xIOG0+4LQsfMGBe5yKeSybxGjqMMusbGisA5DbTyM5Uv5BcXntvCKkIy/UTPa7vTZvZ
 1ziyI0PiqTZHW1hA7dPLJ8D53DwuFn1V6uaX+03ekauHYmLC9ywAcrRHxYR7GMdwZ7aI7KXIR
 ntuUq81GadEUYvPnd/93oGwNnBUncY7Whlg04QpNbvgFSpGLnTP6TbFEZDGO55IxwM9n+jnop
 FKDob/Leafr8tlWKuBifgAMoe5FHXABgcJtExjG0tnKKvzV5n3qd2kpnJoN6Nw+A/7bBYKeNQ
 1r4LAEDG6n8DvnaTehQwr3u1KrCGDAeQ8tcmZc2E9+9vOChrAQBlbqmuJw0lFV6GeQlAC9FMg
 xhStpGT6wtdGJcz3jGdV5bLyvpfa6+dotaoxQbkKX7uJBHfhrJzy1wSzvsLwmqohWUIREHbTQ
 aVGxZJ0JSk92DhGcH8hQv8+BL9uuQEfa6xSFacApB6bQzRXkKkpClHh9PW1KzPHFy6U2euP/G
 LtIhAMpDeEcPPUKWVU/2rlOuZAfq2abWB9lwOJRz6vaGfcL4Et9+/gQkWzCJzSrBMYRwhRTr+
 Ou8NinW832143jqZtBhakkVg9az+1HEbRWz5P6KWFVEtYSzL3P6i2ZtQeeF6WfnGKnOWQ0hNf
 zBeWHQxdkZdOUvGIK6aJtlaxO2dZVq8YHNaulQSCx2lJ4HfdlGuE0zfcZPy0x6/8bzS30NSb9
 cBKVpC9s0fUDeo5lxe1ZQX+AXlesvRQV0OwAgSM5hG8uEwUP4cA9S9i5bF70wVzXNmTetLTo+
 0hkcNeAYic7e6PCwXh41aZhcPaQn4z7Oa4BxGc1+uARtrAGYS5dSyRdeLqZ/rlRcLOJ+tq3Zw
 9QsKYr1B6GnkxX7gD3VoSlmhD8YSVfdpRw9biYh5P5rtlenh8Io6Xc3Zap2XuOwD97/3koJ0O
 XgUzKihYj+UaQ0EWnryYiFgdWi1EvEjLr/5YIPHXmt73rLZjTtdmVz2BHDszRd41tKxIjr8pz
 Nzrc5PFkbOlTEZ8rDsHyZFX2ZB8oi2WofAX/ChiToyrLblnGgGYqlz3TrKn3q4Xn3rgaCJWLz
 PfhY4GKadqi4Jx1Tb3Zwobpo0IT92XMHK//o64TichZbFyNqZweFIAVQAQWyUaLf4djOA6Oqc
 HBq1pN1rI2XhX4Wcxtl8n+v9yTINRnkVc66xepjnSssyGX5g0+0j0KR3HtQ51OMyWWOqR171j
 Xh1aIpn9xbFNnUssqYuSkp1M8EeiOsm7LFiSJG0hZNhUIwyVoshnbkjfgWzmEFBhkgeM6T9vd
 a9MrpgUBLZ25XTuBEwa4MXphHkyqh1+QvfPKqIYioc2EvbkZ2UWJzwl9IjNOAHS1ndeMRgwzn
 DdkBJ9qTqb0rrt6uMAQSx0l+1okyu5T9//bloWAYEOhuRMabZIcIswRKXtsWSwuaRd2ZtsvKo
 mE4umRhysgNT7tdQbtociS0zo0mEOBPiU1kgUCm82k5wRKpdjy7KCO6HOKES73NQGEEmM0Drx
 l/dWyQ3DQvFnXDKqnxX08RN15JDqFQljjqY3yvu0fr2qR/7tct7w2O0A/z3rJX0Ckj1Bd4jww
 oCDtHCgSQyX+jU2npaJ+kKgwIZZsKq08om3cB6/1UDZdkizP6skJYlOBt7V+sHTQYUk6yJjXx
 I7/up7yK6xG7Rx4umqpHbBCQjo+z8l1QDObUn7qc3BMEw2/BjCW1urkeaYRbJiZduiFl6v8x/
 3T2JujLkc6h3I/xedYB2wTWt493dSN4qU5TI10Awsx997c2ry0ZSWKfb0dynX571MM77HDcuh
 EZHEf3UExcrG3jS+OvbV08SRa8QYJCfdZr/W5lzmywrY56ikvpBIFZJYtSlm9SiuU/XJ7fnJj
 c0ytkHtBkve6mrAxuY/C+9hYc9xn0RlXkhqKBEZpX4yLLDAQVAzFZZzT3p9S981PxeXi12i84
 hICqk4FMxX/3Mpp3+zq7Djy9k31kLUApC7MSJv0PNcwv32CCE9E9ZZckyYdhfVn465YBBqSre
 48GONSuwDIhuMlarI0jceJDW5fvEKpXKsM7CecIXNPI8dEkIiNgeVUqZEyl8FO2Md7I9YF0jR
 I70HrvMih3ixCIa7McEDPh4NKFiCTS64Rno2Cqc3nDqT35r28H5ttSN7x87+nhSqqkAT3/9Zs
 /NGLzhTeP+8OphEMuRlEDS06McQUn0pqGlPLhCCsGMqIX1/OgRj5t7zo+O/77fDAP5Sae3fLE
 LV/waCg5nYtmjvUbmpwA6lH1sna1X+ZaZ6Xl63bp0PMHc4ruGnjTUWCRp7QGKc+RtSPROZIom
 U4ZE8n9v2ccMSITiYtS/yEtCHKjP8/xZL3DV16E/6W5bi/45llvgkmSVO9AA5az9N9VnY4ZTe
 dk3XFjYnNrQ3BorrGQuk6vcqgrijDwi4R/QQWjhEl++WbGAv3RPPeSZJMT2k/urs4BHPxRxJj
 lIIlUjCwx6Fh7NjXwkgFDNBU97dhUQlDDnx9UOfcIwtapwKWOFrUND3j7/wAgvqSDyGk4HW8L
 NVhk/vBDH27vP1oFq07par4reov8gFcmvMd6G4vFZ1iUvMiYeI7VSBg7AAdgsNLGugioaTEKC
 Mb0kGiwIWW8yumrDL0LZ75Xp6YmwpOLfL+7otErmtCfMsPCUkbcOKf+T0adNC0mFfAjcYlPCp
 yjCbdj39lw7OYiSh9HVG2iLdYTXDr3BQ1O9+5aZTfyKqnGKilIgsHgGzfxrVCwxZTbkmpnJS1
 mtj4ieE39/1GBFiGPmm99scPVNGCL6MUFz3tYxtY9mRnzaRyUZNnuN7BmEI7ipRPlQyWSddJT
 t0qpNwqQ3t2cBy0GVp8PV1PqmCu8oLuK1sTEq7OCkTwtJK9d+cJoytOn+LI2eOxJD2bwhDMbJ
 3yB/kdYnXxBP+rha/zbp7n8auit8dA5z8YKQvNHSCKahOs7vc+fyXeJMBQmDhx0NicDX+r4cA
 NGUlnYmB0erV6mFJ3b60p6nEp7TI4bY+gUTv7wbudWucnKWV9uZchRH/EeKJv65NV/AGQPaY3
 OAoAKtPDAAHje4CPThJSAq2HRBbpg6HMDu8A3xGPMyRmuFNSd1a0ieS59JFdrd+APrD4vX52P
 +tPXH/lmT9XaYi3wjMpL7NXd7r86M52NNlIejlqi2haOx/2zR5QXYa626welgle6ucXujGmmj
 pdJH7UpzAX5Vtb4NtaeMzPsAEaf/cKtST8AG2SQpQDhX7cvYS3jZo7s2KrgBZ+VBCjifohdIs
 ztsUmxlL5cfvG0HPkeP88dY6BjfyfAKqsqRZiGcamgj+d7pT8WA2zXrwlDhzRaYou5VYUKRCP
 u5DXm2cRlsjOGTIuGkHm0T8gUU967hZXn5m2oo25/2S1M9hWVOn26B0udkqFj05u24iMCgabd
 5wL0Rip7eNdZj7siLzjNn8gsXcIgE2RzDasEtLMPUzJtpI1Pv9ylk7lcw06ROPPtxy6aYIjEg
 F2S3cSI6I5zZ60tE2dUZoaSSQQMiuFn1GGWTtUsRhaIOGlOJrT+2p0daRtVfcnsNzLzATm5RB
 XcbYdt7+hQCqaWVWDYaRIjf/qjKm+dSwRCP/6MYIyHOZFtvOcIO0v7buICuCbl2xBC5B0KrHa
 hvtwpA7/ZekD84jTYe7+Bu9Gi+KY3QBoFjkawj5iOwcqRn2ysCilmRMKLeeHNMp2dxbHiCxLJ
 3zfLKnJkjDzLpkMfcBy/eTLR4/4tVoM7aB728PIR8fqxxFvbLd2jDE8woYyJkM/ZyEIopul0c
 ouTPwCPx2ocsBXOQK+4rgWktiW9W/IXgF7JAnzasq+85AmXbzUXXnRINAdegNvgvMwvRQNsUg
 qiZMezf10ozKxolzrOIhNtcO8lIA3cRcJ6D1yrthY2kFHVSFh4kqp4xPJafbbc27P+GAmEs3Y
 qY2Be4DgGTywx/CW+fLH4EDFkHolMkWNP02ce3dMfRyq2/N/YXUHxHwmmaZiVeCpd4DmQ6V34
 EQaNQir2O8sz8UPRTRKp0+JlVDPvXwtjDb0yZXL58Lxt+RFwORNlvau13nkp1dlAha6nZFe/j
 NdXBleKwyY+pG/3G4pthqKOAeg9/xbFPRzmYUC2VtxSecYU9Q9OOxdZQWta5t6t5TzQtSvjSR
 /QFwLg+IGDsJdSBJuJsCdlbdKtNBq2wHSwFuDRO9j88Qy03CsmvwWeh998J1qYOrojdzfXXOQ
 SVRArvjuFDOPzRg8lXMnbpL4EZpdIPjBYosGoS6p8GktIZxfjYyMY4BuR8/0eHoBRVpab4J1B
 KSh+uE9xv90brXZHhrzTqUy/jSfHpFM1zdg/IjhsmWGysLwNWfi5suLBoEa+/ztjSI75OeFo3
 rnQYc/3AVqbJIQVcCboHapQeEvwDuNZp3/DcbPMmwIy1sEXMKS5q/RUkcFt3pYFwnh5E1xZIp
 fiawyeqZJAmE7IimtMLQLcEeOQIm8Sz6S5AifIpWfyf3pyoMR972GWyjlcGUC10sXb3LbV/jn
 6hkCgqrXgA5wXo3V3plqy//VWA06z2HnOoSD8c6/uI0C/BsQd3lH7wD4GvyRhLKgjB8S62A+3
 XDgMNZUsMDOQaMbX12TvPuGd3QyHm98XJwWZ8o3wPSVL1PYSjluNHI0Ju5CHTCVYNh/K2lghM
 KZnn+eeG1R9KrTwzt/vPrbY2SXlJ/IGevV694Kfx/pOte/Wg/XnSZMELQS3lml38nDHzUk06A
 v/6lHj1QgtfQeAZ7OnBfVtkAa15alSGKeFlHw1LT4rGpt/JgOcbSsHrWk2G6ZJTFDyKZwAzMf
 ODimGvJes2+deDVFf9gIffizuJ4dObQbSU6vLWneAeLNqgrNWLOdv4ahTd5ecMlV8sIhI7Kc6
 QarXpAZ8rhKMHOzgxjlc4E1zUPaK6109gOB7I41Sm5g6fj6yokipCahSUAXuP7S4s/D19F4mw
 2BHyoi6DaEG5f16FnpsBLG1yE6iDre1E1Ki+aLiDb2cv7d2Wdb9l+uvXZ6yvu2d5oEpooC+lU
 ryhpqu0LkMSzEiKLxMAhYkQxviP4fzBVAiafVmV0xHocop2+JQYACsSd+ak6djejiZIctsghf
 ogb+/2OolTMtPWk5Ext7iPI7T70YuySJg6PLXDlohg4etJ2XEGEm1wOIlXdaHYElP+Ngbco+w
 2k/y8tWHNurIm4EIcxf6ipsTXmY0Le1APxSXoHsMY3r8GFEeOw0Em9PV4mLfbd1pXt/dbm2UM
 h8T/07aXMeQ+NojLO7LAQoCE1GnD0kjLgCNOBtkm1VDEJgW/tzuTlQqIDYnGGyr0miK7BPtFO
 Prt+AhsBjzdwRlknz+kuJ+cgX60131ldbVvyaIV/Y1222YwH3Na5y3QFqiGTBzVA4jboPlKH0
 ulKg1GmUTTNW12WpBTXy1h890JLeuoOCNBXnhjuToaS36sSMJFTC8sRNGb1ARs6E74BSQ9TkC
 LPY7rXAudpUvnvnb177SgS9u3pfkSPh2EYdyL6wz20EQCv5zJWlCwN1EJvalBNVCI2iaUw38i
 39b/+t48jqEpUkRrrnZLF7E6H2D70FJaFThaGESxXzvOAupH3RxgVMLXYK6ApyJT/ymtfT8Wf
 roND2rvue7C2lRlk7BoaqZiGwIbjKGWOiHUzBvGk+J90Py2TzGNF/MN/7JRg6Vj/OLy1079+m
 RW1W1GbqRWs8NEb7pcxwpVvaCeHp8GpdGFNfUwwwTVFo7y42NRLwol+/lCvKgyTYscHrYUfa/
 DsKIkYChIEfXnfjrYyzie8aT9M7Lp3NMeJSK+RnubiOPVQWmOOiuovPfRKhwRgKvJVGV/mpxb
 2DhoBi2PzUxwagJQvklytKRXh+VC+a11+g==

Add a detailed explanation how the hardware polling unit in the
Realtek Otto switches works. This simplifies developing future
patches and reviewing them.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 75 +++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index afd52a1cd7f8..73ac5fdcd267 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -35,6 +35,81 @@
  *
  * The driver works out the mapping based on the MDIO bus described in de=
vice tree and phandles on
  * the ethernet-ports property.
+ *
+ * The devices have a hardware polling unit that runs in the background w=
ithout any CPU load. It
+ * constantly scans the MDIO bus and the attached PHYs and updates the MA=
C status registers.
+ *
+ * How does the polling work?
+ *
+ * Each device has a SMI_POLL_CTRL register. A per-port bitmask decides i=
f the hardware polling of
+ * the associated bus/address is active or not. The hardware runs a tight=
 loop over this and for
+ * each set polling bit it issues a status check for the PHY. Attaching a=
 logic analyzer to the
+ * MDIO bus of an RTL8380 and RTL8393 gives the following commands (in ke=
rnel notation):
+ *
+ *	RTL8380				RTL8393
+ *	---------------------------	---------------------------
+ *	phy_write(phy, 31, 0x0);	phy_read(phy, 0);
+ *	phy_write(phy, 13, 0x7);	phy_read(phy, 1);
+ *	phy_write(phy, 14, 0x3c);	phy_read(phy, 4);
+ *	phy_write(phy, 13, 0x8007);	phy_read(phy, 5);
+ *	phy_read(phy, 14);		phy_read(phy, 6);
+ *	phy_write(phy, 13, 0x7);	phy_read(phy, 9);
+ *	phy_write(phy, 14, 0x3d);	phy_read(phy, 10);
+ *	phy_write(phy, 13, 0x8007);	phy_read(phy, 15);
+ *	phy_read(phy, 14);		phy_write(phy, 13, 0x7);
+ *	phy_read(phy, 9);		phy_write(phy, 14, 0x3c);
+ *	phy_read(phy, 10);		phy_write(phy, 13, 0x4007);
+ *	phy_read(phy, 15);		phy_read(phy, 14);
+ *	phy_read(phy, 0);		phy_write(phy, 13, 0x7);
+ *	phy_read(phy, 1);		phy_write(phy, 14, 0x3d);
+ *	phy_read(phy, 4);		phy_write(phy, 13, 0x4007);
+ *	phy_read(phy, 5);		phy_read(phy, 14);
+ *	phy_read(phy, 6);
+ *
+ * After one PHY status is read, the polling engine goes over to the next=
 PHY. If one bus is fully
+ * scanned it switches over to the next bus. Basically the polling system=
 is always busy and the
+ * MAC state is updated in real-time.
+ *
+ * This is a glimpse look at the complexity of the polling and leaves out=
 the C45 case and the MAC
+ * register update logic afterwards. Important to note:
+ *
+ * - 100 MBit downshifts (broken cables) are identified and propagated to=
 the MAC correctly
+ * - Access to MDIO_AN_EEE_ADV and MDIO_AN_EEE_LPABLE works via C45 over =
C22.
+ * - It is unclear if these sequences change for different PHYs.
+ * - Access to Realtek reserved register 26 (link speed) has not yet been=
 seen.
+ *
+ * How does MDIO access from kernel work?
+ *
+ * When issuing MDIO accesses via an MMIO based interface the final write=
 to the command register
+ * sets a "run command now" bit. Between two polling sequences for differ=
ent PHYs the hardware
+ * checks if a user command needs to run and sends it onto the bus. After=
wards it simply continues
+ * its polling work. Inspecting the command sequence for a paged write on=
 the logic analyzer gives:
+ *
+ *	RTL8380				RTL8393
+ *	---------------------------	---------------------------
+ *	phy_write(phy, 31, page);	phy_write(phy, 31, page);
+ *	phy_write(phy, reg, value);	phy_write(phy, reg, value);
+ *					phy_write(phy, 31, 0);
+ *
+ * What does this mean?
+ *
+ * There are slight differences in polling and PHY access between the mod=
els but the challenge
+ * stays the same. On the one hand that greatly simplifies the MAC layer,=
 on the other hand it
+ * has some implications for the kernel PHY subsystem.
+ *
+ * - Without the polling and a proper MAC status, some of the link handli=
ng features do not work.
+ *   Especially an unpopulated MAC_LINK_STS register cancels operations t=
o other MAC registers.
+ * - The Realtek page register 31 is magically modified in the background=
 so that polling will
+ *   read the right data. On the RTL838x polling simply resets it to zero=
. Other devices seem
+ *   to track the page access "magically" in the background.
+ * - A C45 over C22 kernel access sequence is most likely to fail because=
 chances are high that
+ *   the polling engine overwrites registers 13/14 in between.
+ * - PHY firmware loading can have issues. Especially if a PHY is designe=
d to expect a clean
+ *   sequence of registers and values without deviation.
+ * - An access to one PHY will need to wait for the next free slot of the=
 polling engine.
+ *
+ * Conclusion: The Realtek MDIO bus driver PHY access must know and handl=
e any interference that
+ * arises from the above described hardware polling.
  */
=20
 #include <linux/bitfield.h>
=2D-=20
2.55.0

