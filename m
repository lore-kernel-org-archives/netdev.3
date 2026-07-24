Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27532E7635;
	Fri, 24 Jul 2026 05:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872598; cv=none; b=OQ8XHFZ0M5OmZk0CWWUSFmC0fjFpJ2iLj/LS8bddTN2t9A6J4sOmGznWZpB3kOb2W/aDgBmVSUrhwCrfzDUjt2s2UYgI8PjtM9ST45shUJbrus1XDGO/RmE5tX03cmssiMMXchALsXdCracx+OyIJD4NbYKdmRYo5ML2nvzFz1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872598; c=relaxed/simple;
	bh=eeG1NUtHhjtFdJ4HgktHPEmM/fSrUx6scfx61x+Swl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKho8Y5GbqyChaTBIOo8biD5MwqBDd4b6rEjg+YY7UfL1wgY2K5YIiizhBTl9z2w4AVTnNy4OTxsIjjr+a8p6wlYGyHjJQ5LH7/bg1XuQlqHyCR02pl1H1cnz0DR27OrG9LtRzhrlqeB5i+en5DWI1zycNSWw5uM2QqZHbhc93A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=WhdDPuUT; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="WhdDPuUT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784872587; x=1785477387;
	i=markus.stockhausen@gmx.de;
	bh=Ta+Ua/abDS5p8EmhDmBPC/jk4pEpQVYI9II5VKSpTps=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WhdDPuUTK6QO6drVv76iRjoovOmCwz7YDdRHP92Sx3GWZYlBfIwd/bF8mgger09K
	 DRn+1h9Vxv8jtIPr2qEZWRVd3c8EuWyO+5c5BQqHVTjri2rgsXs276i2qgYugZH9r
	 7XYOEmZ8bqsx404ldU3rBQxIWQ1M9z2IWsvGiG/R3nhO3oi4y4QSKiv6PQN22Psp2
	 U8Y9NTQsjnCq+Y1dVPqzvatZSfexh+iBTCwgAFRx2WIa8e61AAMNNPUIx3Z8vb1WX
	 Grhr1UMOykai09FpsIHvfRrjgDPwr8AQHHuf3QrRGtCo1TBhkjxuEi4Tr+6Uoya/s
	 KBrRLA58FXdcLL/f8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hzj-1wwWLc2M6h-012paX; Fri, 24
 Jul 2026 07:56:27 +0200
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
Subject: [PATCH net-next v6 8/8] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Fri, 24 Jul 2026 07:56:11 +0200
Message-ID: <20260724055611.1008577-9-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724055611.1008577-1-markus.stockhausen@gmx.de>
References: <20260724055611.1008577-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FF66CPYMR2nlk3jGw3wEB6GMFNl2jVCeoqfM3AnGEPWz0R7qmNc
 WfUQTw3rgeOqOPzS1uf8gQLaqJghe2a2yr9JJhEHtPOGixwothsk+rhzeZwy8gwaoWOKDWP
 //VwVxe+xVjDk9Yhlhk0MvHv3ZPdRsBoDwK6FFbDGDEW6lk5Gvj+RqyoCXV0vPn2SABiECU
 hsxya0KdHoL3MweegvvAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MAUbk1ldtoE=;S7oNJ0Vw1fRowxdOT9ZqdFzYlCG
 DeN6mLVU9pYLWECiOljeMt2KH+l40BdJt3y0TNmk51DCaKH2Ss9i++73/Uyiw6F+hEhldcyqh
 za4f+P4/fHZdSWh+0k3HafkGQbDjeN3AzR8P2PEJzpIozGi+tNM5ebl3kQRaY9P72tH8WC3Qc
 YwCKOgTO8UzCXxzX1ElqnFxaHL2abLRspiZUDVOok/qIdKbhOJy6d3nwMh376UvcqfOauw2WJ
 2YSHHjkWgOCM8PUBMznfqBSPEVvUhLdbmlm1xVYf4kIZG+oNPkMu8qkjk+Z2MudMRLFlkFDNj
 uBPngdJFX1/YmU2zX9EdyfPXqPAV2ZzXUidTTrJ09t5HX7KTb0w9wGucXGiNSLpbGzHQ1LKC8
 hm93vznS2LlqlV3JqwFtCAi9kavAe+5oTSfOEND9KHfs+sufiQlfO0mMDE4H8y6zsdqPRvl4c
 7gcKJSm4/k5FhCL4fylqkQxEa88XWgP3XJLIohiU7nTz1/nnLU2S4bdUvVIMcnx48wZOiRzib
 TgTP+CLVTY4a3fpKzuHHKrc/YkZ4LEZCFebfePZk2CSSnynVsxEAnAqBPo6XfOKxsQ0kKZNA7
 lHOGIdbjq/TdrmV9USWXtw1tub0QhRfessl7w246q5pnYpvmR00cnNfRxtaIDFKanVDFvZWzf
 5Vmow2TT43BmvbDDFk/Ha7dL1bif11EcHZVHjSqr8yoVHXCXG9pzAUN4I1nGu9xn9SFdbMo0f
 gOJxydkiGEuGdNaOfuOoBsEne5Zm2trkIamSSqqRKE2fec4Pw1JspYaU4YtrnCALFbv+f5oh5
 wo3pFNVWmH2ZO+sjah3s+9YnBkZ5K3yEXhc1AYRbYiNUR7VZ2z8Sd/Z4jCuhpiSr/SQ0Fwi4k
 2bsp1+c1GqSQf30HrY8Fq1JCa/IxDvHfjI0ycv+5pHIihdY53QzO7dufWLfcgUvH3dn4F02Oe
 oUYrxfRzlXwgHSiFK2M92trAr5JmyaFVR0YjtmtACw3/H4X5/+HbLQI6extpLDyqqgB99fe5A
 VShZpPEMSiuhCu+Le5LhWIystolEVmD9Pv7j70Mr/teyXD3l0NwvLOlQ2riG1ldFASznXFhaZ
 a5dEMCW0A+6ePiWVVheLRWyQGJlxQlma1BSBKncMJkWo71W5Nuzj/s7Ky4R3wylqEpsVYJC2c
 xnseI/BrlpMlVi3kM4fKaIadBrvr99MLQIMEoq+Pj9d1axJd/mbn/Kgpqhl2sBZDNLGBAD2kc
 d4kXsHPYSsgYPhbqfOP7JwXk5WwZoytfe88s5Mac0hj6laD2Oy8Cl+YF9ydg1IqbyI50hAqAh
 9zgL1Sv/OpqD4bk80azHY0PB4aqcZMU9Wyd8iMcHmkglcf7RR61ot1J2zpTH2FQCrC/pE+nQu
 X3mwcl+RCBtJB7KkEQUbh4wrs1PoZlj1HqAGf61/MV0WiAAA070V+O3UdOtB+cyMr+4c20Srq
 zGUlxUCqXg2wmeppAQUZGGUC1MyuB2BP8vHBhZcuE7CAlpOPwWQM0oWhGUHkkmu+HFdz+L/lX
 sO+XeoBRW1YlwK87oZ/tauQH3532Rnj4RvIz3PctCSo2CTyf9RZCquY3Uqq9+MSnqrW6AP/iT
 fy1Rt2+SM50Yx8rJezS2Hf9rLSXweARRb7Ly6vJ2JoPoNcqZulUVomDS+gz1crFga60B6W4HR
 h9XjBPIC3Vfuafww9IJp48WNf5wetl/C9IsXKd+VueU7SbWoWo+FuVI4Z+dke2ZeVHPfjVoan
 D5NXAV8o6TRxCyqprubB4oaVR0Ze2uF9f0stVnXvc3EChI0uX8olnMIBiSuc8GpkLrH95l72i
 ojNGgZFMEmQ/Z4jR+dhF9LI6I9eD3adphNEyQUAxvP4ERG66cfoKIxncBIS3ngcfdiOVIBzcD
 7rnjsLDJmHEy9lMZIpZbNi4RfegzGTgSXPa5ao4bzVn7QEjcINs8XTcyXU2kw5TAnx2ONW0sm
 QO9+wkYW/eNZ9LHewlz6EV2+mBN9MzqHw1QYpmV3Si3FTH17Ge3/6EvrG4XQfgkwrwPMTYB02
 2tl8vswvI0vkuH0PkDDY3GHigsNjvTHsNaZtOwWENJyvReecYg1/rOBaU5p0KSovRTkwYQhA7
 C+aRRQlYDOaMIAl1QMCqnUpEQoveJE2VQh45Z3e5KkrulzIS0mhNs0hbxUzB+wfhiASwZHMFA
 6WXvTerNgPUDZOJo7aUxexIKKP2NepkhVMnWHiggrQ3gTqTT8XN4tZCVkuO+rUDeSMhbKuflP
 MhuyUwXImIM6hUHVBfHhq5Ee9ZbR8MqU7AfQQisC68h04wERWPE0NiCkvs3noZZvQTUKgQBmW
 jHOR23++KNMjhTJBGTZ3wtQ7nRaVBZVwZjdxBZqe0ncmCR9byDGDUsAGtUS+qAjJeOZsAWmVW
 3eBPjpWkjCveN3SksYV1yZ1AhQ7ND0Hxp/fLHFjqI9uwU67AKduoT46RC904tUjmEVNiyezqu
 sV9nnwaH0BO0Ff6I2+rDwZ/nF49mKA3ZOhcBM+ev6ZtE1H2GSZ1VP5/iL+0H7nnS97Kh3s8dC
 /TU+P6vm+c2nt7JWaC2/+becwG49hlRqcRzXz5vTH1DR9FmVu0mIJI3dfy/1yBRC+MmYY5QYy
 6UvwAgvzxmyV+DLrvdrXuJE9CfDstGfM+B1BTntnXOOBWT3ZKc9TDhjtrB6f5LY7xY0gKkrkE
 4oDfp/PNXojKn8nVy7R+tm8idWYuFn593YKMqQdGJccFCVc2xxJTagA6Y9haJSQQWPKvECiEk
 IQL/ZkeRJOEGdkEYtcWFAJvv8qtNmoXgFWdwoUBqlxy6RZNv4RVOzX3gsLeaZFAX2ZOg8XVjC
 a1szJ6b7FEmXWQgSIW/MaL3pEKaB/HTExR8N8z98/z1gCIBLVb6/CEPwEVRZ+ObQTssZaE2Ml
 oaa9uHb8MFZLio1XhaQa6rCnymWNrXPmyJdGQioeIHzdZfC4bRTz0H+zw1XeG6Xut8xcIgLpl
 HDTTCQ4lQcOyNx34Ysyt/paKIAvqN0JX3xHWDjP1Y49U1ZlIw5V6iukEKmeraZ7jwgCo2JkV5
 BH5RwM+kyQpI6xJeZWTdeoI6/ux5H6rBx8SIEFFIMXqMRjnFqqt/JbpWM7soQW4gAD8sliJxa
 3usctTOBqitZZZnYtcAHVUw28rBtqMzwNOUbKVpb1P2Dwl0A7IwByNluqw8UMc4MBDYcwRYN/
 ++d6WkzYOz9n16RSBPljG0p970WZjkTTkFhOEvhJ6gtJSDIJVKpk2yU7/Sj5sPrgSIjcsNv5j
 VdMKJ78F6z6y6iwu81WW7qvUDQbDhTQ9/mllgOdYAg+fzOhqB3b0/paEMC6sBJZjg9hE7AeIa
 4+5sRvmjoAeQq+5hWvc8bqKLdtbu+RbC1gR717eFFlCg/j2oQJ7dZeM/FFTgHN0A0DPJlGdNR
 PUw2D+05Jo2G+/xQ/YHLv4S79AsBMK6A9Rdhl6Bp/iB6FnkVpQNEh544NetV7ZomwvnXtrjTy
 wZB2m5Bsv42Z5tgY4Kqh0f0c1wqrHB0PbWhmJ28T6Xls2MHv0lM2/dwmiI+iYUCGBSmL9WL5+
 MZ7D3k5hR5QRPdFiPcruosFK8gYdky51MS90Fi74Zwd9R9BOKeuo/snEDi4OtnXp3gGrM0hrz
 R5jKxBX0S6+iiZJ6f1Bx/C2BYUdWHtGtzpJUPCq9mJ/j/wxp8KR2Jt/z32eJ+75hF1Z/ofbYT
 d+EDRcr0ey7kLzpbdPa9vJ7NhZXlkZ2xZKict+dDtR4tWDQIBUnPa6itXfKubAnTVYv+1r5GF
 Ji71frFmOZtfFGpgA+oe0lkGYF5ZlP+YOQFrL0XptKFnBI7/44EQNvZyPT2nuyd3MYg5rsoX/
 9kSDXNKT4TaogID+/U2aPV9VswcrVREe846RDPK8itTkXuUOGxIm30GbiGNtIM9wVgTCCLBH8
 uV4LTqr8MBEyq89ifYV4eBbgdFdSszegdbXbPmeF0dz9cBLSGLkCmWBTkaAfigbSQpjnIAAK7
 vG20eft7Z1kmdBSMWEZdf/wMwF4kkWR0gXOjbgnGnAs5fizocFL4Udqlpp5MvdqXAvfOpNFgT
 CczIDO2NZ1TIyRPqdybExAZWXAoclRJTIWbcyupR43kBXrWr3417eE3WMuzcWyecfZAIIc+O+
 fcHhQK17I+DY4CymFqv4RE5vcBvuP1X91WAh4KCSiXJj4fbU4q5cwSwIgjQ0Cu5/D40malav5
 MtMCfzuNHxZKKmd41K+EiDd1lpVJmOKBFm2uromft7PmHAiB0T/1y9QW6d78y7+grYO+ZDn5U
 umpnhor6m5rFPXvKwf7nmJ/2uxCZo/Pe7Jm4F3m6zlqmLqdBowXGj6BYmHhmd5sULZZvPmQbZ
 E/cfzdksN9zMfXOuUPm1W7QWQ27GIkU18+CH6jaDHJVgC1CTk4Vro4I+oCUgLx1VS0mmcAat7
 qKUZ7ur03tMrz+24Z7IXTXuOU9QV5c7jzOuwD5td4l4/Wplo2jR5E+MNUgTQazgwAxDhifxBg
 qKf0OSCTakYL3XGLmEtVuo88rTWxPz0zqUjBktP1vBPEt+g7CGkri3iYWDm7Bn8iLCrIkAKpl
 6Irrcx5+sq6ZS6Y80Ke50QJpP1kQJ5Duz0gpyEyd+b5AJi8QciKlXBFdueLS9hhPfyh97yypO
 6QCW1GvDKgCZzmjeoF+LUaRpLigDBgEFsBj7tsF5SSKT1HR8bru9ZBS3kL9Jyg5xRlpZZoRiU
 EjXaHMsh43DoZdl8+wBnkuv1RVjh4J1cth8OfRcIIQFDf8y2g1EF950cK5j4x7IAqXBoh6Zsc
 lQ+J9g8zfGqXUcQJEjXcWcNU/pBLYs6KurQXNR+E0wD28lZcOKcfkkgLdk5k+YlUevqxtbXdN
 QFFGwVLclYCXKRdmzrXzZL3MmCFE1I9UHmlaJ9kxCqgaAINfGKwzmeqgTaEmy2pmXihhRMtZV
 BQdeMPmLnX8oHfwxrp2+zpz2QrlmHW91tt087sZGfba0y3yIVfTyY9lrpLiwZ6rzauOXGIaez
 rEsutokuBsdcovMhllobznqglwnL7jKQooJJR5g+YWhs4UYGifKhh1rD5cFzHzMNduH/LJmYD
 u8Lj98RdkRL2jQk5Xsu9xBrAjLaaC1X6HwBZjMwKSIQ9nyMT9SKbvbvD88bM28K4Db0rCI51S
 cjxVjNFXW1SXz9TOYiQYIRHUbxTm1roTq2b1F67nN+3nzwVBi3XxlAC54sGLLx28jnp3okwHd
 lHj2LLQjqTXDD/Lmm/jzQtb/qyMOCbefTUuqWNERN5dGq9NWYJBZuXve9UQ8B/ZwBY0IYZ96r
 q6auYXPVhWTWvoTlNiaY/FeNvT4pyJwLjrNn/n43o5T80yAKKD6vTB1tbRMIDiG5hiKReQFxP
 vqs5/lutppMSz5CcuSWjR19SSiVkEfIXdxoE41YESeBwh4MxhKl6s7vSYNUexwoDaWfgWtPKa
 uLLjiA0KFKp9JTfkYonvnjlrr0t9kl70qwBb0Q/mv6/LeyzamRvKsG2gJRtbLE4HWVLpEqt6J
 NqczFq4gqCdFlz7Ey29OHJZ921ntKcn9Cd3uJEHqBWqQvcsPdWZV6Qfr9xYObPN9uBwuwH9ai
 +ej6QrKRls9+XSFIbY3WQdnsy24WDRZEPkeFy8nuBpXa7dq2ioudmS7HEiSvjKPF/UqpBIc/c
 rFtgxUN4eC9SfIF8I0p92la8myQ9phLXdMFPJndLWoQHcCaA1Z200K7dhKP/qcsU8pZm9JnT8
 KtewGEn9Q7xjLAlBmjyRERnf4Fl8igjMEzkDcz5ODrACH8cC0zlz2LCB/5ct8pN4j3IyvbCeo
 =

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL839x (aka cypress) series. This is straightforwar=
d
but some things are worth mentioning.

- The device has a lot in common with the RTL931x series. It has 8192
  (Realtek) pages and 7 MMIO registers.
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
index 0b1a71e32ad2..7b747828535c 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -147,6 +147,28 @@
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
@@ -427,6 +449,62 @@ static int otto_emdio_8380_write_c45(struct mii_bus *=
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

