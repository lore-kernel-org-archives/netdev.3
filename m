Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F3481AA4;
	Sat, 12 Sep 2026 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218327; cv=none; b=SL+yE40ZCjsDwmKIvvE4FkXl6qbgpXycACLz8nEu6oUzbFkqrt5AQUyQonkZfP0ZlqELe/RnhpkJiinxdu6H8Ev5wLvPafWBHJcS8IXjC5uHYEUohi6YS5qpASJawIaAEqqj6vFfEnkXc8n3xZpcsjsSuriuSdXVsD1K2LeadY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218327; c=relaxed/simple;
	bh=JPyj5R29SpF1Khc8EEeyi9P4bSdI/mqxjVOM8Gn5IPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THWvRxhWdDhmWbFsu35Ez3tSP5MBmuUv0Ze8JP92CVX/C+XjWxjwi3JwKi7qDIegwj2lhZf81aTur6FcEYGeOyOKiQ8Q0dQx5he9EcyTCQRnJL8ghTrWSP1g6fg2MpTq+qYBHGEErFVoAzz11cx1BlYLCQ+IUn5B6JjURmBbGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=MSimvY95; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="MSimvY95"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789218310; x=1789823110;
	i=markus.stockhausen@gmx.de;
	bh=9bQXezc+J0qRuM6+9YpkpKeQIPTwD8CNzOhNWaOHQU4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MSimvY95folJJdbE15gRDMu/Kkbc601wMjSCkjEcf5HN7P2AeqWKqNI/stXkyBtl
	 vymoT+6kz8GUABpDPelC58L1Qzs4zUqCwhCB+sJfVazT1jGjAXGLruaix5yVnE2y4
	 1IM5jw8vznrPpo+UMaY8hb+5m5chqQcvet048S0Pbdvf1DgjPtZKMj01yInD+CIYw
	 gungdC7DgTuRrcVMNDall0hesAYLsYArGitm0GhjWEVens24hr3uxX1Xj7AqaajIK
	 80pJTUUlE/kPARyJ+d6ObuswqwHw2DKggcF8siY6ETGgv8akmYD71mWvjwmjHQjPD
	 YCOgqwLeUKuvFfxr+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lc9-1x5eOj03rX-001egG; Sat, 12
 Sep 2026 15:05:10 +0200
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
Subject: [PATCH net-next v4 5/5] net: mdio: realtek-rtl9300: support non-default clock frequencies
Date: Sat, 12 Sep 2026 15:04:51 +0200
Message-ID: <20260912130451.3757276-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912130451.3757276-1-markus.stockhausen@gmx.de>
References: <20260912130451.3757276-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZypP/MxtPPUX+TtG7synraxFXht09SMVotDuc1VijSmKmUSgBDi
 vsnah8B4RLJe7Y/NVhrZvRzHFZNq7iWdinckpXWelr3APF8OwfC+hleozR2/FtiE9N84B+q
 lFWKUs1I+NpqPeiXDDqnRSIkSfc+IUqaC+D4wsuh60f7DdXeite8BHdbDx3Ax6cG3gG+b0B
 NAhr7HakrrX3r0e7Tp3QQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p59tqI77tV8=;sdE26pWeJSwIwO23j4ZQ3GuV/sN
 AX9VqsmeabkmTJs5XWUHzO5/l78qeaW5LkSbBBloJbQ4RaXejyUvmOcMvwPtvLvtftLw7w5tV
 UXl96bNj5bspEo4BvRdcTn9Lzxbwc0NLLNzYJy5mpa6Pt4gtNYM+ATjPKG+/YJZnLlv8T2UnM
 an9PvErvin0VoCw34u6IYUKKaUD6o0VriMWVCgReLIrYbs9XVn8O67kZRIlQ/PaEMr1JwrHFQ
 xcopJtK3ohW7d6zSS0MGWALzee0MZHPCsLdU3IKJsbCZbwOQmjZXUkNiU+aUd/oYaqX3uYkki
 UpZ9ynxFtoss7NtX3qsHVOAEZK0uyMv182vMZ1EGx0lHM1JHp8CjseXaZEkD7ccEFoQH3NelW
 7ASLmOdvGwdNC13kC9lmk3Y0+z6UFOdf16ej7VJOXqPBIGTrdN1HxhP3Udb2BscZ7yCMOaBgA
 5qBJsv2gHwDrNXsIp8zHJrmNYLzFRQq2okjLWPjvJPToRuxf4IZR49ua15Hpnz6dkAekeKzer
 SxQdcWz/mm2dadn71tSoSBMFLPZuqqdR7kbPSxAM10SapthHAe3exuQLPGpyNCVvNX8PQHLmI
 P7ggsri7k7Wbx9bT/QYJVSWcHGW9N4EfqGMk8q0p6y+TDV6JxxXMI4hFrOtJlFto455NywFB+
 GBwongJmWr4Uik9uSxJ/AhJtlTn9a7nvSkT0I/iRIosHchX6HNDKHV9ii2sZjWXFtZpbQKVhZ
 GQrc/QNuA33ts7bMDT0UPoGXSLXSa1c20AP9rysI3jY/SrJp6UPg2hsfmgBgd+DnaE2M+ndst
 angRVfsuuoD97e/Gp2BdXPfzKqexQI1lV5T3yp3fnOMqfl6Ihl9t64gP2nzcuXT8jtUsDNwcc
 mza7IN7xOR8f/7arcqIX4Gp2adVkPmtPaG0zdeuIYyc24UtkT4aVKy7feShwBYnjB1dBdkPaU
 xT9xjl2DT0vHnMZPuclJh03RVssTdOwnY/Ui6haR/Buie5sZpN6e2Iz5l+DZaqiV435Zsg7Dk
 7RSqSZgnOd7qbsZkXixIKQ82Q32agQZ+kqIy0He+ZMKUwu3Y+PrSOYhIldSU4C3LBLw1dyQ2s
 JrBzVn6K7rPwFse2SrxbTsdy7bnxhXI+TOiDwY9gp1Sxz7JMvo2WBhwNclvZhgovbAjsomIQh
 2K0/1YhE3tYxVq0c4QxjTgrDqSxwdQ7aJawxuLOUp9axWBOfcyWDjkoZSLx2assB3imYL5CT9
 Y7Imz6Fgz79KMRSJxm8I/sMfb2TrSw1qqDnCgJof7Je/NVYkPU4hXuW61NfmmPR34QbFlxgMm
 0RnImHAlk4FflfEIrkLxynLcfdooUgpaGRETk5eyFtbuKRvU4+gKhEnhTL0jOH5vmhhFqSwPc
 TvHNcv0Nb7JHdvmBFzopryAJAaQCmipCPkEMNzgwv+1mOL+Dop2yhm4/rF+wIwfRh8gYrHWbo
 Io8nZ1VLgJ7i3xBbDX4J2mTGAhVCy/LvfT+E4Y5kXgn1zv0ZzFNP46wIfonjnXBUzTHn15nRF
 b3W9js4mocQDK0JiDuyV4jWsZWWxTllSCEtBJ1fCfevVyz/Wth+o6KpTfwLxkY8O6aaiNeyUD
 QlWIKKbD5ltW2n0N1zZId9jjJcKgZTBHj9z+W12hrzUH2M9iSuzxy6/sMNcSUAS1siRWaHOUw
 ab0gC+bYeaDnqEVgUQeUsCNHMCG4iTtTcXb2i6ifsEFIQ0tsOm/a/1fxf1dP+XHC+DH2cPErK
 splu6dkUwIXPEGF843tVqP5XJBWOw6VIKfxw5ad7Fg+Z9o9gjC2S1UumTXZjsbN0AyWZPS9Q4
 yX2DwrC2JENvJNkuOxU9Gnc5i+l/z6C5wTZ/Aq6eKPjfE4vqB630P3k/hrBxWK+c4B6EZ5/sG
 xdTxwhkFp6uYjmvHy6Zwv4tP0343PArtUre1fJ2Nlr1Plnx9TwTaVRAwEPahLeTpI3GIPSKqd
 1uhFQmFAHeAX7kXNh575iLqakP/0ZdmjAovwiHzKeX5E880dkyHccYU53cDpXKKNY0G6NDChT
 WzB0qZKjthQhmEvrp2t/lQfFw/2d/DHey9x2/aSP8olAs6oheouXGyQMcZKDedrXk9uZdfHAn
 du5WBteBDk1qLGRTV17xNxsdohKPMX8+o4NdTkeIgzI5ln+iZTigWg/uG3TLWh03Xnl3IDgKb
 layZtU3VKQnkGgEv4JK1IThttE5ojHaWxn9bYl9qw5q7v2tCgx/kZi9zc8t5mbNODTrX2MmYb
 zlln1bPGmDXzhUOb9KMMqZszLHYkrXXA8+Iy9zitBj4gBRlRe7z+38GXG/aG4XiReKeW6j1B0
 GoBKvyc+h72U/YHqGL3AK9bqKOTmwzoUh+9Wd5Jz3XdIPT01K+8chQ4iKv954Ujdbo5rzboEM
 H6xRm4yAbwewoZtpZSkiuSU/3TOm3tkgI+wljdbo6wf+40+vHEuVXSngRv8MlAWRPqvqvyKyz
 mGTgimza7XZ0UUcSj4j9WfBKwIDo/qjRn1ABUPuks46kWoKPN9nt0Yb4kKNlHqvcM2DlZNxr9
 CSGG0WY/6Pig90nqXv21GUzsexYSi24ont5ZdTl4Q4b/lKozg4oZxt+dPwv/IkP/tJceO745d
 1bAs+fDuy0BgeSeSlLsllQLqp+2RUb42C2FXD64E2qfUJWWRc1kZQKf7nGbAAg+k/856mMZtV
 FcDA9GtXUdTsSV47KNkPwnpbd5d2tpogJ8EaB+cm7AurCBUUWNmFZNp85kXycFBLRVELDZL2A
 Ybc0qi2B59ZhZcFS2yBF4p0R535zh/DEZ5kMaZEQCyTtkSEqnaDfMU84vUjUSNcNbLMnJKZNF
 gMwbpJ83zVPnlWmoX4TVdVi36aSqtFaLkSafB2PfXHvg/fH2d8K2peY7WxpngUSm3jEC9HDi5
 5eG55DB2xENns9QPh6osdFR9hU6ebQOxUPdXhowHuZaG4T96nPSiIKCGKV7UzUCuVE5eu8cbJ
 +S6xWZC1I4N+zvuxeWT5HvFJhPIAmxU9a0lp3cjMGnh+HK/6Fg7oeM0be5dPP8IqDImHOJbdG
 r3RrSqbMYR5cVEs00Auu/7QP1eGSu7tSVZ9mivFtPczzfrHsxYOfc7Jh6ZyY0GvPnsb7M+Z33
 dTmkL42iPo2cxGCd0DtS1cQ41+3FGkA9Ug+9gnqZVh7x885zXjIY/FEQWoT9a+ygShRt1d9zG
 ja31n3/JHw6XGfYG5fvYSk8kI27VNocMFhdaU2SQbvkaVmnoeenaXJq/FIRvwjdqEQyNuOLrU
 KznAlucBL4ndf7XGHZNU9y8SWKVBp2nHJWHx3JG7mspID8o/nUpoTAN4KiaF2zfnrfjynPog5
 h1lSpowF+FmSlIvivGCQy6v/cczCJdohYnrE6PBD0x4XPEEep9XeUFdX2k/80WnviFm9swA8L
 vS+ajs4k7nig1BZ1qLIfNyC5fJJtpT3Tg0sQHMogewpVzxv8OvFsduv62m6/xDCldb+yrnOy2
 +C3mpweyUtch3VWD6xwUbtt8p/+35LDVd8r/OVzr9dublncHcw0Eb0rebHeZWnPdRmQ+WPNaG
 wiFsMYs3LBJqjBkygK8KXa4wWGyB2mYgv5lBlMyUZbHOXDkQvMdZL59tl3VPwZBqICGr3BTs5
 yYA1CKoPtdGVqJUBGDHE9C6HiFwtTJ5hQ4AiNRTI/WVMQR1+B68DuHZuZ8ex0nE0HcAy1ECSf
 CHCP/q7iimGkg1BiyWKt727Jv3KnCFkB/kw18DGsvrOD8AneyHDTtaoYbNysTjo1qn7ou1PmU
 0zCySk2/UBA4B2y35ieIRp9L1CjU/WPA/+3wtpWGSp9ZqhMnFMZoZFJTnRD2E/1rSiC+OOsGb
 AfI07K6rpfxsPKmgN0gfkjwijfHop+kXy/itd22Vjz73UsKFFahgrb/RbkjyU1cl4Om3Xu1U9
 e8MQ1IluKswc7e9/Ckqqc6eSc8ErYnvVrxn9MA5G4Q74DrEWqoubH65fGB1MbtMrz5mGWzCWc
 KbQhNRrNzwWR5+pz/7smOJHZWMWglK8R2+7lLjFfG/swEUyYGtjm4bqlIs7vl66BjdDUVoIh+
 YbrNPucv9H2PthuvX0kDcPMNpNmt9u4MkE0jTjH0KswcBTwEzVLDDRkFks6OPnD2NpQ0IBD5s
 IFas6DNIrwY6sfE6KX2dtl58zaJ6ijO16HfpEXjqeXw9TWFHlSOooCqjhHHzqil8+qmGkw69W
 +mmJ5fhjh+tXRsbgpX4CGGvx6MuhwqODt4keNkDQBWEZ+3VXuDcnIm8jiXhIW2uQpdmMl8Tf6
 4bpQlhulsB6VI18Iue2VOxyE275UXkIBpBdA9k2wa3WUd67Pxn1KRZ5j80JNqmIejckyuATkf
 gJEktYX6cDNORVE0bNdukpC35jtySH9xPXnzVYI0LrpgTQr/YkOWs3fm9HRrQKnAkS+9oKzJR
 +ew7zKfM3Nohhn9HiGb+8eB+x2nTADdWD2F52T79OmEcE2BIyXbPHh8pHFvzHIoc3ot/u3M1U
 Xk07YKAo0qch3YQUVYl2Hlz9+4Zn1vIknDckjhvmrR+9+Lx+v8+BoZspJmcR39qoi1v5Orp8k
 WVAekHWbgdoLKCjPwLSAHzrJQIIk5DOCM7Z2O3puGeLHYNUM1C4qWF14oEzWU/o4s7XbDYrEb
 9I0bIM7GoXR906sTUfc1/52B692MnKLkq/Rl+v0yVo7I26GMTMJDbmmPgwj8DAi1ap4jiOk0r
 EcfSqMq9ti/1y3VrqKYK3jKPw88znlOEj/nAWWUmzMNNyhO9NAkMqoM5S9Di5MqakZwtEQuHu
 ocZiCP/0JtRQ7D8l96JDAONGvYcGWXDxLdZOToPLJlBtKKBB2ASp52YGhORTiLZVu9e9mqx/B
 VDc6Wo7zypgppq7NAQ72dGs9WuCHZLm/HttqgjT31pp8nJxhkzEIgqcFszDBomqzG9yICsDYY
 2RZI0elcjWMpvsv33NzDIOuqiO9ZF/S0HAzvtDBAh6LLxjo6pWxeZ9VbJMXA1m7pTvzf2Kvvg
 YYCK9vLR+YmNTtPm5YOHeiR7VX+XG47F1jcebOJ6W9LsOlz1kGLo/5Ntd9Q2EdpBdHOgFnuH2
 n3LKtu4nZDLShUKE3hv9Mf6EjJhcWveTnKranrtcOiv3jOne7Wy25yENhSI/Iv6Zw/2ek37XL
 hdqvdz+ahLN4RM3eCzP9OT4B0LgtUEg9zGFUNP2lZu/YJ+2YyP52CxuXJGtN/PmKSW6CPrekj
 Xck4Eim2owjmw9J/nmU1FfvUXOTQzydZFwkkf9mp37eISV4pO7kDs4Im1uJJfxv4IbkAGLjkm
 T3rcr3yRGdax65F8LY2fmdUbD3IsrM3qJQqSXHv/DnUtQxz9ZkA7LnwaZYdBUb0mwa0lrfU5D
 vWZ3RyRHgWeeaL/HwoK4P+BmDKQsBzVI+MwTVTdMYruF7gu49n6Olr/dNeQV/dRVSm5X8UfxB
 APlA67/+cSvP58vEW89ZAZ1me65SlCygKf0L9ZCvjTbqG6QCUQoVdIqz9oi6slF/U7chVOWHV
 YvJBGNRnHEyEpmbCXeRXNPQEr4e1Z4fKO7Eovf0fXicXH81rF/OGKxVpd0ql9JyP/ZNBWE2GR
 4Cg5m7aRnNaS87XdlvTZZaOtDh1tOD2xKu3Zp34KUfIGj/i17+WM5EJf6mQKE9bdeZu0BhDVv
 YHNvAAcnH6TlAhzdbbbdOaUwnJfaU+AhSzfY06RNG1qbULl25vYya+c1yOmzKKGykc6DXBfnh
 de04bd9PipBKP3noJ41GzbF08jSNh+SaU8tYCNGjZOJw0kx6BvPy+U4vzAvJX5XETKCyY0y5o
 R0+slswJFRFYK4d+l602w3yHHtvYEwxN68wJ++ZBzxT/DV+LqXW5xc4PqO7KQpLZ7Dm36ZkEK
 wme377gi5HVlYrL7yxwmZG/VJot+ruZ/dbFbM0NcCfvwEj5+zuUzEAI2sRD2P6Vg82hMB3zyZ
 AVpClSMq6RJ+/HJis3OCHz/JK3srehu0JD5jHZ6jFWJ3bJwyDSHVWV7PbZsBrAkzqiW/qZSed
 IBhiQzZaxPnAlkAT0Nw3wQb3b9bzq77RbEIuExKsiOfRzVpLlH7tHjVSMVcbpTGy9Htp9e00i
 MYGfmb+LTsqBXqfP79S1jDdzj+WD7EfXUNf7iruqdB9uwuqv3CJpLob9nCP/1rD1bJ2gzdMtF
 i+eLNqE6DZZk//95s/p/wvn0YRkrbFvL/vulQA5GlXVKW3Di2dTxKHOz4t6mG4T5ZRzBhHBv5
 l80gPmak8+8ky8U777ITj3xwoW/5Waw3Q922qId90vUnso+h300mcZUkMeW5bcBp2JcXwRmSn
 yHepq/uKiIrVlwqyUJausFtjxgR7+GYTbcdphsHJOBDHDTPWPJgYPrhaAse/qCctw+4W7D0mP
 H/Zom5CsWfK4sZCJW3i4Ezvd2d9xJmE0AlHkQiUGNIEdNHKAj+TjOP0CRQWNtbvpubdz4Xrno
 kCMJi2SIWFzF3tabzEknqVS2e6oD1qzOoQ6RimcNQNAUemR1oLsb9LdbnmoPVOzmRsfg

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
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 100 +++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 45cbefc52100..bde0cf5e0b79 100644
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
@@ -268,6 +274,7 @@ struct otto_emdio_info {
 	u8 num_ports;
 	u16 num_pages;
 	u32 poll_ctrl;
+	int (*set_bus_frequency)(struct mii_bus *bus, u32 freq);
 	int (*setup_controller)(struct otto_emdio_priv *priv);
 	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
@@ -739,6 +746,17 @@ static int otto_emdio_setup_topology(struct otto_emdi=
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
@@ -748,6 +766,60 @@ static int otto_emdio_8380_setup_controller(struct ot=
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
@@ -768,6 +840,21 @@ static int otto_emdio_9300_setup_controller(struct ot=
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
@@ -834,7 +921,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 {
 	struct otto_emdio_chan *chan;
 	struct mii_bus *bus;
-	u32 mdio_bus;
+	u32 mdio_bus, freq;
 	int err;
=20
 	err =3D of_property_read_u32(node, "reg", &mdio_bus);
@@ -867,6 +954,13 @@ static int otto_emdio_probe_one(struct device *dev, s=
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
@@ -1055,6 +1149,7 @@ static const struct otto_emdio_info otto_emdio_8380_=
info =3D {
 	.num_pages =3D RTL8380_NUM_PAGES,
 	.num_ports =3D RTL8380_NUM_PORTS,
 	.poll_ctrl =3D RTL8380_SMI_POLL_CTRL,
+	.set_bus_frequency =3D otto_emdio_8380_set_bus_frequency,
 	.setup_controller =3D otto_emdio_8380_setup_controller,
 	.read_c22 =3D otto_emdio_8380_read_c22,
 	.read_c45 =3D otto_emdio_8380_read_c45,
@@ -1079,6 +1174,7 @@ static const struct otto_emdio_info otto_emdio_8390_=
info =3D {
 	.num_pages =3D RTL8390_NUM_PAGES,
 	.num_ports =3D RTL8390_NUM_PORTS,
 	.poll_ctrl =3D RTL8390_SMI_PORT_POLLING_CTRL,
+	.set_bus_frequency =3D otto_emdio_8390_set_bus_frequency,
 	.read_c22 =3D otto_emdio_8390_read_c22,
 	.read_c45 =3D otto_emdio_8390_read_c45,
 	.write_c22 =3D otto_emdio_8390_write_c22,
@@ -1101,6 +1197,7 @@ static const struct otto_emdio_info otto_emdio_9300_=
info =3D {
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
 	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
+	.set_bus_frequency =3D otto_emdio_9300_set_bus_frequency,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -1127,6 +1224,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
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

