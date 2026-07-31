Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883E362152;
	Fri, 31 Jul 2026 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478472; cv=none; b=OWVVzjX++ms4RKdlQGP04TNptP+DvsDm8qb6ewCjsmCUzE7pzA1K70uFy9rpEWGGvnmdP4JSX1xnG+jDtpBY83GJ9o0YYQwlJHRzW/4baqfHOQVh6W+noruxBSOdk3+Umn7Huofzywc8NXDzyoCH2etwDjawqULt62eOPrKVYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478472; c=relaxed/simple;
	bh=7XF7MAFcn6wmhhyC+2PeG3mULjc+Z8/NfTpPK7cRYMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxgaxJURk2zSPGYhFj/MT8b/W7+Gm3xnKwX+L3ITlpzeG8pkPvWBHtX7ClbSL8CLaaB9p2NJ0+fnF5OBnc5g3wcQDZ5/Pkc+tIDruzye7GCw/YvYN7WFRZS1Xu533ZHPGY6Rjmy7pNKRspw5un2wlSag4ABog1cy+4tKYJDqWIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=tXPr/h1G; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="tXPr/h1G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785478453; x=1786083253;
	i=markus.stockhausen@gmx.de;
	bh=/v477jxGFogne2VF+I/GTTEyVDOS7HCOFPYfuuxedmk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tXPr/h1Gc7gBO3zaBBkCS6+WF/wPD7s8dx3WUm8EM8w40XJgD3B+2omvM3YWrf3c
	 bzsqarQDavaKtlNytmTTK7hPLbi9bNuDwtPL7jpMGj4fp1NM3YyCptoV0R6O+HEPi
	 PSjfaImW4AVTtdDbc6QtQM0tiGkXPvUFLsKtdN/oRbOIeH5XB08ldvsAUUvzBs/kH
	 lmhvlxICLaNdd/oHWv27EAqNZojz2kkzpV7Ksw2fFR2+FSiKJsE2WIzg6+yT+ztwJ
	 GqVg4XTWIlhvM+AFXoKBsZ/9pkgHOnKS7mf0KJ7NhNiXtF9cNcT2NCPIeXoMY2lv3
	 Zn3P/7dN8/EwK9P3Bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv31c-1x7UTV2R1c-00tnaH; Fri, 31
 Jul 2026 08:14:13 +0200
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
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v10 01/10] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Fri, 31 Jul 2026 08:13:51 +0200
Message-ID: <20260731061400.78301-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731061400.78301-1-markus.stockhausen@gmx.de>
References: <20260731061400.78301-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KG8X+UkcewLBCiweYSdLGK/VWTc/eLmo7KU3lrxIxwceJcsemQl
 INPf9v4PvDF6PfGNLbX6eh31v+t9Qei054tQFdNjSSltO2haEQlupFDq2JHdv35zim8ePtY
 lvf4xeXw5EH4aPucuOKAG+F4+dfGPCMsI2uyyWdKnKCsArK0rriwkZvS7lf5lFA/k/z5b8B
 KyVtyQjyrKVXLws50imSg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w3tJmFS8qbA=;nfqrTolZw1nWFL85keavxYay4Oj
 /H/twNKLaSBna9nap/j3cCoOdFmw/PFbjsuPs1gzum7oBYNR+O4YgdhrS+bAY8AQi32X23X83
 Gbt5tYWs2WAeK46r8Z8EYeYOt3rKXJmbtYmZ3YdUyQtKWLAyshXeON+A0ZeORZRS2ckOOUWV+
 6UmxW0yZQCghpDNB8ekVZKljA1sawqfhP48wiPV2MZqm0aLIkjIS7bvDIOlsafpDAnqaG92MX
 krJ+STMmdbd6D1pxChl2Z/G+RlI62ZlmJW+LWZh0+1gdDOJSiJpa1KcWzmrR4zVk0TNNk7Y3B
 fk8mkxKG23/CAUFBztREKNTSFk/QGWzFCvaYfW5ZaNajAxxJfK8SCiERJKNVt3d4HQsOhlFFb
 jeXs1AhXQnp9ly4a5DEzSs9edilQ172l0yYPgQv4QKXSs0Rj8ae/htOpoG9DLX4DnsJYU8dq4
 d+vWzLL2CkgD/qzdY1AOrIt4wtzgH5V+YmacUC4UcbGWXTTl1+ol1v6qUcpez2sNUvOhFlRJu
 F8M/4GGqJuAnd1zIgfROsciuB9INRnmyI24L/VDH85WuONSoUH68iGz3HiTGi3gQuwtduie9B
 kXSfeVEEApmpS97mKhlhC5RSxqvw1ldJqmbKqPrQUDcORTSLGLRGPYaG1qBAj/Kr19nL13eDt
 uhgIMcc3IWZm0Xy0Hby9gd+uxOOgzHB8B0FRSiw11hqGNsdRZBMj2JfO6Ps6IHsAVuw6Tsy4l
 4tuWUS9Ks/F61dnxZzxyCuUbQ+e5cgf2VrUIKeXVaBjdex7vMF4duG91x2SYiE6V9pszw7BW7
 BykD+H50B1aJ8pSu+paEiRT1dillkOtmSKHhB3mOBL5Ffacw+kiuYibbZ/oJBksWUcZVEPTso
 aYOtpsKdR9u+F99c5cwA9gbI+BcC01HN6q+lD7hBNS5MXNOwcp6vbUwRUUruuNX6ye78mB50x
 pNHfM2dZI8BuU8wORyZSheq3WFLK3ptvGe0w3+mPSiaZjNjpKEYZ0IXSMvFFMiKnKf9sVMk0C
 L/jWBFR1eDu2QzIM7um3UTzYA0V4oNBJ2CnPV+wECaPoTBxbpJORLgW4bMYyZKKTWnasQJ24p
 APisDlMeC7Ab6W2b+CwVaHg4+uRCLWsEF7fa+vDHdPNXj2R7sTTRVArSbxP8Y0ASLkr75un+o
 8cYO2EtygWDSVOh2k6PiW9qzBTqxpIHINkSCdC2pG3mAX9/C4hhe2aAjGa21qDUTvEVc/r9nb
 xd0bqXvM0iADhL1YPTy9g3kBt709M/rfCXcU0jA4fIHmNlxCU0D8/J9gv7YLk+lixXxjjdAvp
 E8smtiAu3jszIw4vhMBRI9HZPiC5Suojcu9z4Vz+1u8YIxk6Gx0elmmhLGmpSADYNXI9+2lRq
 O9mpoxwSpa5DuRuALgCozxQM+EEuOxiJtW5VLrwu9S6I2Mb7A2pPOn6pWqLK6g9TJDlgOEYyg
 6J8GC3ltBbTKvBarIHpZYUPtscz3F/s2j2pLesfNvNumJX8GzKomOQ8iOYks+iWdtoiR19E07
 BstgxDf4vL3JWUvG2hWi4pFQCqlM2huecABeDLIV0oAHsIH0INwAO26z/NaBgOUplGOrBTXLF
 KvoduqS3+KD6QHurLvVpeTa4YPwsuvtLaw2gEBuaMnf6eqO+1ZlUDI0dwMY429qEdjV7VH/Ed
 /TiTcEokia0t2B/Q9x1b/NqywtYYEcrjACQy/LJufqcYAIVpMoLM0bHosd5+O5AR/1CUUNtf/
 nX/puDCDgZrpmOzcEX4oA7lgtOw/o45r/ytbYnmec1wD+aI9U2VoH6/fQHTd4aHRL/HQqRH14
 F+tzOAptccWKZI/UXBvux0o9HiI2MukP+9nRyzwoVZIk8sjY/LaA9/ZV6dsrDbnexRQNG9xWI
 nmBA4y4aGDLtvx7mJ7fd2gJKGdB26oCbDhDnLWkMUXmyaGdA3CXGCXFW5MzBDWq5OqIX50ujm
 1t5C7qd6NAD9UmVi803cJlCqzXIcXZq5ZuvyCJ930FlRmXkD4ENtlmzJAEgRYCJ7LCODQhZft
 WTArKP493Qy1emyzlmfVf4jaueehMtEd8ta95wsbpmhcntyM/tLYtubPK+BiTExhZakKyMIm2
 syIT7zfHUVi3qP8xtIksK9MHJEo8dOdafFSdYIWwhRA6XTVKcjUSbop36bcqblCggFlpttnK3
 uORxgtm1SmT/QW2CHSSBCobtpJL5gH/jHHcyNzPdZBNyNInzCC/AiOftxyVJ9ZSE2fnHkWQF4
 3DSp9YVBQ705TwFgEiZ57MJYEB7u7JNi5EZ5Ol7Rclauy9aDQGY36d5favQG+C1t+k9Gmigm8
 E+BN2eolbX2JPhJ+6rQVSNTWrQi8eD1Meo/9iNU3hcx/8rrOwSZdwZWISRerqHtDYRHOLzr5V
 wLf+mAzDH8jtWeNVuDmgwwH5LsT/2SbFc44d7zU3WlRiYWWL6iebvx7+V/MR+Ffdl50Pek9Fu
 4JONik05bGkaogXzaWEvOKH7eCbyJuJvQus8j9gSWPRp+5Mt8lLNoYZLdzUzlCrjNN4Xl3X1X
 x5QE7hEnJJvj1ZCDbrH0nttC7XZyd8/96r+qL6r82NhWOX7fZIXBARglAawkZBDhKBjTKgibV
 xfYCyKKIMCTJlQoH8j1vPVCV5UT21ATi6FRoAaPrA7GcbimKvhkk8m4MvxvcnfrKuwXRXYpVW
 LO/bibzeGWRdS++3MGKXRYm0M74+qi57P+QucIabs+EMveZWubP6k2rhpasjfmFRHrT3TFk7q
 SMSvos+t7/X8eWtIDTZPghiy74vXrICxJx9+ytGVAT5tnRAufOIXTCyBO7JMGV5LC14u4wSDy
 mK6KcLpzkovd0uiGag1bwVhelu4dszTs1TXsu/dy7nXampZyy94ubgLf4uod1q4bDDuMhE+1t
 Agy6TPZ7Y1qTeJJalMro4nAtZLzbaYdYjsy6rWQ/sFc0yeDspZxZ37fli3lRh/Jv3PyGD7S2e
 wahlkjeaqTYZOYSdr0eF8C/xZHu0v8c82lTheJBmyDlBPzAJz2AgxLyVWofSbhCWhnK5W+mGv
 j1r35ytU+J+hqY9ND9DTBMC3zs2nn+hnqFjX9OHdxewv1GLKiVLo1v+sRL1vytwSvty0+zxot
 g5OmVXSySerVRhzGBSV9/LtkcvpvYgi+DBBfSHsgnSCB2BpBkLd6tqf9UGr+SQfQf3WKhO6h1
 r2jGmomaLTB2LuKC2NmgH06EhI98GeiOCs74+znXs1/svjFUmsmm8IAN2aiRYpDwl/2B6/ar0
 ykQW4fbdU5t/gnWt0+GBVVwFy7AnYS7u2M4KZnEiVfzEbGezcdcg+CykzrzymXHHDo43+0kty
 WymkxBuQlQpOsnUVjem050hfpSHo7SVWVM+y96w62sdkZrz6hto7nC0JwGjG18QZYSggg4v99
 E4u235CchcN4Vd2tIhxJ2FYkYeBDM8i+rTVHibYZMB7h9gADuYPZB5TmHv6zZggrwQJpNLkYC
 RIHvxsHUdvru9S0yXdurHJimnmMhWKXL1PD+Y3tg2Chz1XXcp2sYShQj4fa96oh0ciTyzxO5Q
 fcbXY+cxx1koyVnaHB86axqzZg8WryI+hWDuVhEyVxmMAOXaKYKlF1a+M0wKz+l4m3tgN2BT3
 lxk7c0ju8FVICXlUxYxAdMmZgJWOpnaCjiFANyM2lHR+2E/V3sROWWZNRZH30LEKBOrSLQP2g
 3uYQxsM39GnzgUeu9KLxOJhOSqA7VpCJgYSret7cPhqNI6pTO/I0ty3wiFCz961heGL66AFCH
 QYA8ukmBBB7DxvxQMWZXXLRGG6PrBLV0/FrkGJqr6D8R2Kt8+BpyvlI8AIhTvbYoXk1flCATq
 tPxwKR+pFLEHDeqoiL5I42dyHdparsMQkA7e6kIYdlO7ADK1qZI9ds0h+lHRtIsi/LI6l6ebG
 U2IDee7HXqFYtD1umV7DssSkpd7niaZvXG7p/ytePKzFOdMJK+xEnt2BEdbOKPOaLVxHvtx2O
 aSIP6wm/WijgxV6tC9VQJgMv5CufHst6m2g0AW2tVIf9stiu1N3DrPRWzzNcEvN6F9x/cpK6N
 QH/2YVEsheMZGopVbTApQ5bkGrFX3TeaLmmiy4/rOPHDv5StFDWEVXJwbSYgWVZRZjM5fVVCh
 0jXoFD1epWpA0vL4ppwUcZUZX2lpNALEap+N03keGWu8ApmaoYFIDmx0J7Gi+GIQ0n3uEJjvi
 dlmyqAq6dJ4vueovop98H5YsJ0JZdLMsq9TTjl3LD7t7d1E6VP2bTpr0ZD3P9N+drP5QtQ8SF
 vbT6vGA5LPq0vzMnQ20JIMmETpbWouPjNcixPxXE+hx/VsIZrlTgvQgEU/IUfaPLVpbzMf0+k
 dr1jbomJbyZLhJRt4nK6RNDT8YYjOqEZHJjHZJwSQbyuAADrTaxgbwMUNsaRVQVUdWE0pw0oe
 ig0mhWjFtvDssIU33RDJ3k2FYDMQyAYbe3ZETKMrm+EF/oS7EbhwErYjfTCM27kDG9q7PvCeq
 JX19+8uFbuYPJ6/ezBGzNCiHioFFREidPM+2og4+6WVv4SLL9pYfU874WpEIh/Uz30G+CqHGQ
 s+nu8FfXed1urCzLlLeFP0e8TLYmGcVIQzo5AlW+5zXSGXSnvf/cLRtEynobktYgINDi1lJIF
 88ipbFgRH3ZqPjkC6h/44BPc3SwluSVbTcrCYEi/5DOL4wmj9xAgiWEsIOp8b90Swqjdxa8g0
 G4ZrR9PyJNFRQ15xtBQp+Sr/AIB0f8269RlOuvEpUFVKLe5BVYCQTIRA0Ivambwe42fZeuUbE
 8hzVId3hKsUR9o0m6EUIbGanhS+CWx/TAqzG70C6POmX4nY9QtzeGlBbf2aBdEUkpZ+I/5npZ
 dJLpyj4aV4Flaa4Wz+zDzw5iJ7NOxnIE37Jc0XP/DChJ2MN9LnAz2XAPIrJhm6SWOHZuHwA25
 B9V5kDktmJnv+sma3oXiFcZzbinRcAuYe9eJxDxmkIyEroo+2xBCdHe565mL4J/rqOO+hcGCA
 PWpVTeJ3OdnBjPf7xvIBBQyx2/m5XjLkQiYmL7yqiKrtzWcdm+K6HkIO+1ysBx/gF1ALUT4Xf
 m+mIHL55SrFoaWCqhB0wWYccFnWZsCOQuO/9oMf73Nwde9tkN6OfxKWXWBb3ReNjkj+1hUCg5
 p1BEj2UaTVS7dgliTX1Q78dQ5fiLYa5QSUPF8jLpgt5Pmh9YnLbcVnCo4uhC0PnRXMjwxAqAm
 grv83WUlRWr5GAdkau3zzFVgzsYDpxk9exb7mMEyiJBMTFkOrOHUpvGHv+JTTyXXk1dsKVGQ4
 yUV6lGPWoSs91RIsndldn3FsKjuw4OxIOgEeINazWPSY1iiiamidEgJbUuGXCfCCqLFXPMV9j
 MT7BNzkooaBfQPF/uVQrqnLK6tmp9AzryzZe7eEtpothhXDEGxu/zNefNhg+B3LmWte/8+Z+9
 cjhYm8aE2HJG4wYnUmFq+EoI4WjOGIBNNcm3Gn4cqnfOHj0pZHq3I4u5xxvBu8ewcaU9JYrRl
 6gHMlDiuLqiDBeTb0M6dbAUJXtboKAZklfWIX8TMSCRsvNXx8c3z4jr3mMvc0C3yI6hjSmU5H
 1GSl3+m7wWDT/boD0ZdxL7BaUUFAQ0zvOAQKZYaTdJGhHus3urdFOHz9MXePikcQlsVOmx5H2
 DH4zlCWe/VADx+TBcEsuULrRMgXmIc6iPlL9ia0pddFzZhM0d/mRUq0UL8H8QrGGLHNxEdl2m
 DFp/b29VfObwao72uyE37JXe7V+CD3nUVQv+yAgHQVAGcFFgViZT+X5tjfllxJZ3+9BZNhKg7
 2/IX6zVGFVGLPerDh6hBAdmSno/dowX/Omw1pIiBFmg582jrjgG3eaLA8+xVOVzLjNmvkt7CU
 XuuNRZXBs9/mLQ2SL4UiJQ57VhFJ9YsWkARgwLp5+luvyl1lLObIK6I=

The lower end Realtek Otto switches provide 1G only and are divided into
two series:

- Maple  : RTL838x up to 28 ports
- Cypress: RTL839x up to 56 ports

The Maple based devices have 3 different SoCs: RTL8380, RTL8381 and
RTL8382. The Cypress series consists of the RTL8391, RTL8392 and
RTL8393 SoCs. The MDIO controller of these switches works like the
existing RTL93xx logic but has different characteristics and different
registers. Add new compatibles in the device tree.

With the extended compatibility list change the title to better reflect
its scope. Especially add the "Ethernet" tag as these devices have
multiple MDIO controllers.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
=2D--
 .../bindings/net/realtek,rtl9301-mdio.yaml         | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.ya=
ml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
index 271e05bae9c5..67e0b23a8470 100644
=2D-- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/net/realtek,rtl9301-mdio.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Realtek RTL9300 MDIO Controller
+title: Realtek Otto Switches Ethernet MDIO Controller
=20
 maintainers:
   - Chris Packham <chris.packham@alliedtelesis.co.nz>
@@ -12,6 +12,16 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - realtek,rtl8381-mdio
+              - realtek,rtl8382-mdio
+          - const: realtek,rtl8380-mdio
+      - items:
+          - enum:
+              - realtek,rtl8392-mdio
+              - realtek,rtl8393-mdio
+          - const: realtek,rtl8391-mdio
       - items:
           - enum:
               - realtek,rtl9302b-mdio
@@ -24,6 +34,8 @@ properties:
               - realtek,rtl9313-mdio
           - const: realtek,rtl9311-mdio
       - enum:
+          - realtek,rtl8380-mdio
+          - realtek,rtl8391-mdio
           - realtek,rtl9301-mdio
           - realtek,rtl9311-mdio
=20
=2D-=20
2.55.0

