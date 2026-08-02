Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571D835C6B0;
	Sun,  2 Aug 2026 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659751; cv=none; b=QzU5aphIbuN4GWuO0GQZNEr3dCedLKI+HE1NZMLTcP5ws0w0qLUcpvlB0+Qi49Ypi7kOcndDt0FVtS26CAqWYOBTvu1r2/WZE+s30ew5g2+agpduSh3OSWuTL/O2hAAyfZR9LrpOVKguiOKLRTl/UGxtGxWKsTWEf4DmG4pEnuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659751; c=relaxed/simple;
	bh=SI6ewa9CiHFTcSbofPtuanq2d+2ijxdyXyhYxC7Iwvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIbHOKp9oLiG9qJzOwv/u9rccRM7oYYnzVu+I8OkDeZ2xEIsj+XdGtgX4uwhRCcy8y6lS3ARfVVuG7/jTHr2ht4RMx9vwSckCNHhinfUy1jRRjgp3kv5FQ9cYr4K5oQpwbI7N76NyCv96C5+tZv10ukUYA5md0tgu5cr0g2HD00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=cqYjO28u; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="cqYjO28u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785659746; x=1786264546;
	i=markus.stockhausen@gmx.de;
	bh=gOKgwfgtLiJV/LSq1OF5arvQkF5Jm23X8qdpRyzzCmA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cqYjO28usKOQGAymELcjv4wyPqftX1MFrH5X8K+5TXZcRbHrElNrkKoLsAiVclib
	 Zdwm16CU1T5/0dgCdCAUBDFwA/sAlC0wnOkg73eVtPSlxY9ir+eHLRxgIwN3Kca6V
	 mxORQA7ImivfJJs/ctfF1l6eaIxIgzK/1ug59O+vaN+TNflk0ru7hGC1zwV6C/UJD
	 VHvQzs/xZEuB7m1crgocCkW+piFtYWxAr045fO435RmYNjk+Dgbp4bAFa+KfTuL2V
	 AmH03doP331Vh/a+ly+6QmB94oLoJm0TIZ+B20Jl1U3JzhWZJ/YOQfH81txWvceEg
	 p8sNjgLYzIYCibwT1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4Qwg-1wxqGl3jU6-0137sn; Sun, 02
 Aug 2026 10:35:45 +0200
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
Subject: [PATCH net-next v11 06/10] net: mdio: realtek-rtl9300: Configure hardware polling during probing
Date: Sun,  2 Aug 2026 10:35:24 +0200
Message-ID: <20260802083528.490216-7-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802083528.490216-1-markus.stockhausen@gmx.de>
References: <20260802083528.490216-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WyniYLpYm/TUfWA4B3nb3SncDU3hOtNocRV5ac+6H9DyZnvjr2e
 ccJ09x6Uuy2mmKdz/NcmVAqWb8kqxt184rmoEWKj9IvFtrnMHzBvGg395OoiYf65WhS+gCy
 Ep2rNTUPa/X3FbcHGODusktu3UK5qXoHlh+UU5pM4yAA3nhIIrs5tzu1cRVsWJQlx/BKuAL
 +6Yeujj7W9CFqQ0TbwA+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IWVXr10sYFw=;XCM0zurfcYBt3PqCCjPVZxx2t1v
 Xj7kigdELpBIXmgdeHTVPAehxppL5zCQKHPbfvJENGIxoMbHc4GGe9OETUa8P3AiXTu3Hv8Xb
 twCk5REZ0Ozi99A0FJDBXPOmiA1OjFJ7eTjrMZfAmx0vKaPL1AKNvWsKnQSeHYaqf7qUIqcTP
 au/WYSWDarKI47vrZ4ieP9vrHomW/pCxQTXm5LMaEve373lwwHfxAmFsOW1BM4ZRq3SgjbKuU
 jJ8Auy4grSYo8yWtczaQirPAxuUKBPe6y7XEu+XC3XQl8ejPFfxfEhzkL4pild2b3Xwzqau8N
 o9u7IBCieikFBqKKISGVqM8JYe5LGu47bvMOn+DupHNc5Sg5BbToySPW/osZr3dBCGfUqO6H1
 mJgba6V6kjqiT5DRDiLximTlE1QbJjBo+uG66Qha3S7m1ItyaYLo1mc7FKxqRLW+GH9Gpv2iu
 PfyP52zOaQCMrxbZpfUrr35gmoMxhOtaputEk0fWQrgF8kvSPETnAEIEBvFD1O0bxxbFdMDOP
 ppo/T/4H8IdSBPaQL1sywKIA0HlOPYlWg68xSxUI5+SlgWMkzIwFzuJUqFn98QpygPsL628Sa
 2xu6ssKcGKF4y8iuYk2L8zk9YG+GMDREfw54YApwspzhhgRXkTaOiXrGKJdGp1JZ5/gHxDl0D
 Egsf1fyQ2bLeoFT8ezxGhwAshobLROTdq5yKPXtG0Dphbt4Xa3dz0yd+YTYXYjppvrOXVjnai
 GilJ5plpJdTA5B2/OQxZ5QYIcB3L1JS9+us69Nt0BXzbM5Z7NPpWjF1ZAqoaY1tUSz6n0WnAl
 riw9TmeX1GlACT1e4AgUsgf5e5k0wTQafbCnwYLvRR30Ac+RSAjHpowk4ZzF9fGogd5T3hEoj
 YU/0+aWWp7DvfJPTItEu68cLLL/kjrpxXfKtgQv0wkba10bSy4w+LHPYhE4PHMeXsf2WEsk/s
 p9WeXXTrxefgL0niSi8LToaaku9cxAdzlZSht9k9cTCBa7B2UQ2zwnQ5P4MkedNpzxhMGfkL3
 WFv+de+Kzu5LCcqkYlBAXpShe7Ctq5zZWFwmVFwawAiJIdOwGCZc2LCwfeubvTL4XocvTcAtp
 q18469r2tQaicXPDtA8frhQReT3f2esUZYI0m/BjrVlNh1FGI3NaVCk2HdNSKlBo6VbyhtxPo
 0XS2SON4n9nXpfT3OI20ZMSxGrBMBpyxvOoNVQajIytgRpuSnG8rASIvQ8c2oKp0UtH+7POr0
 ZLjM8Ic0cpIYhI+JVhBUFJoqTY4wX6M8sLGnlB1srsB6+CAgZFMLAOO+03jh9g/zJMf/dyEIB
 gDCU8gXTpuIrhPo+UJnumYIEe5AbQo/Ax3AuczDS4mDDztuoIuyL31ULCifGDi9zEn2t/dQpN
 c0Sx9kOUTtg2bkiHI6jBrtUa+slszGHDl3BVdjUv+E2dyi8YE0hXsumoQYG9OOMSP8+OuHK2Z
 P/nBCkSHIBoyJmDh4GTxLr4SLQyr2sJeQ6QaKYMVGoHu+0unptLYglKr1FbnTQh4Y3tLxNJbo
 q/bw7mgOjj/bl3blIKRIYC54+vEg4pDspQl2kKuPn4xTTi3Bb8BXrgFY3Q+rt57ibd9iv7ZQ5
 ksJvceiKGr0X94DPbj1U7eQM/1AbtxE4bqHsX5PBKykAHkiBhOuiwfUH+hFPrEDOIMx0caULR
 nwPFH45pWN8uXoyzUggpdMXp76NHP1jZisQvtklMbBHaK+KekKgWEhCHSnwA/ju5i6ERtxowt
 8e8tnriivE1nzbfrDBHbRb89270V0Gx9DwIXGYrqxpIhVYW/T53ZzWTGh/GCRDF4Q3UVLgTiC
 A4nwx82ZTXiLCQQAZPItid0zNwehdyxhg9sMSF4vOxpGvrcmk4ls5WySoRiaDad54DgbI743Y
 i+LsliUqyIGSLnQhOZsGt7jRJAjzOFVp+1Tm1xbdUIQOEaZxqGMcLEec3QrBsFqbUN6PiWxOx
 8HUVOLJfc2sULtrdyJgWHFlOX+thHlyPK4v9FW4VXmhdjHc/yFPp3YlHURbNUWVJ4Irk4RKn5
 XhKdhBjxSSQwvTDHvKUhMGXxKIYw009mxDaSXzXxsfI5mFJAwl3qhYf9DmpqVCGYY+Caqw6H4
 Eo4N5DJ/PH7HhLOvIYXn/zBOiq/EqnNOCo/wPeAslJhcpMQWYJHYebLP+Xz1U9TX5ZQny74Fo
 EZwvvkGeMWZ1MJApSzkqIFtfLvRFrq8nlqJupffrcZklyHmiC+XYoJSkWu45EzT8r2ZgK5j+0
 Rjv1l3UoP+AlfXC7W9Rp2HPnqgHXcINcjlpTMVSwWLwc5bdqtiO3vRObSdQDnt/dVEcEsg6v/
 M2FL3JBNEKOXZqhDIkY5jQVK1i/cWZeoK/VbuJ/wj9FsDAm/AEi0MfgKgSSArhSrDiiVH2r54
 NcrJBoobw+PTYlIhgrh+0Z1ejLBctIGbLeU9LQH0etGiv/d4jejN9kKvgYXKaYvSzoTrf/HDU
 F6d6/LVBkY7UVqzi3wOFZ+59M1fklbHhtrtLO+3XebeUJoHJiUFvRsO1pAcoyFPZJnPeoglkn
 iiEfJHhCBYQjhSuXkQkgqv7bavnPVTdpdaHJYmijuO83ukhtzhWn3Y+tYI0A3sRGroAz4D6IS
 XtQMOBU4QgG23fL58vAl4WtjJIQKfMMz5QdJORcEQb68/SI9WdEz5FZfovHXc/b9Icbe8OlKC
 aGKG1Vsx9XWAvjXRMSZNhS9CxJM8QsEgeVNuB17hkMIOrU0ta1vH2Z+yUDDi9rsagPDCXFHYF
 acxtFrFbPCyS6tYW3/BcJlhIZJTYcmhWh0LqKXJDgogkQkLejtzHrY6t1V2mdrJOsGnk5MBi5
 BAZLzYW5QQ9u0xy8LxNLYvEr9MtWP7NBT618zFzDZrBXIoERZhG2U+BZvnXwzwEKKkrl41JCh
 RHsh9E+ljPt5OkJrXt9wtUXGe4EKbzIXZWV3zZOZdet8AieK09yqLtrKW0BSIFMjlttZqnnk4
 M7CK9V7FmkJTd7TnV1/lAjQponbDEY0hSPrqY1E6QIpz5Y9RJ8PnV+PQ8QveUGP9XbzGchUY5
 Y8e+eJoCw6SA8zMcfWmhFcWdMjg/WQ0OiHHECC90vU7qpErl/zByHDMPe+2RyNo63JrEfDF68
 Nj4SYHZ1Nw3HF5vCM+UAChGQBR8JB/L38Gk4rKR1bVmZdjNWM2sc6wKAgTyXEiJRo0BA4P7HP
 PNpd+VwyXLfzsGP+XLhs+lCEMnu1zG+nj+h+PwVjbXrpWTrfDxlI4B5l+IJphxNM3B0RpawFy
 tAyf/DdZXvThRAQ5j4f1x7hiaAFPc+advvMSKwr+ZTtSD4O4T3Eig2kPfEsE26j6q4B2spiEu
 2hW6YDchZ81S3YM2LaIYYM4o1cdVMMZziK4B+MPb2UreesoCk5ue2Ra5YMEKh++H4M/fkhGcP
 oh8TsXcY+mfgv0FC4MXnZElMyrJnK0ABGosJX3VFQ4L2TE9/FQzE9Mrj3Pv/KY5k6EvMcdW4K
 MJMbLKK+cLbNnUG9BgPz5qGJpDtfaP4sMYCguyxxQ6Mzf7Hpo2sbPTrHXofFLi81NxHuPF7D1
 6vYHLZxL9BgUUYzbiR3XjNzLaKznCOcPlDGTzKfVWzya80bs8C10xWophsp7sjwZjW4+NUSHr
 HEIdt9NP86olM2TTaRfj+j2VmHTjbZGlm6OeukEp8se6zDPfMzRe5hA/O+qEg0lTdvDX78DgM
 SRObbgKU4pHFFzg2thU9b8LMbWwsPoZ78a9mktqSBRrW5+r+g5XLQzHXNn5Nuf4Ns3MkngfT0
 Gflao+IvkwfwZ8fueU5g6P4XitFHE1rxCPRYkX1MYS4C/nFYDEKPno8fklLadysM7gpJjF9Kf
 uImHlbPGJkrvQCkZ7H9bloiE1xX54cswnwxzGY38qWYiYbkRdyCN5FncM9Cx1AOWWueAYp1+/
 +RuC0Jwy+H66pVsD9uZttZAGqr3eJ2XYiuGonF2qmnDEicy+ocO5yeyUN5mUfLQ3eOLypssJP
 W/K4VvARQcU6dPcrQ3Yga0AougnLCKrQeoJYAn4dk2zICb6lqrKcODVqrgBCShqY3ZA5sh73d
 L5Mb/ukKYxaBYtU/SV7N44gdgvmPdzj/IdEepdURR0f54wvPFWHxnOaLl5iLBl0QC3rDHktDn
 biiwmVowkVvtEP7tktXdC5jK49kViMFPi1S4I/B7ZHfB9ScpHJEajMIkSWdx8DBoxigWCpdP4
 /6C9CM62ag7NRzxRMQlf8X7DhHNEmzscGWIFc/A7WxzfbK2voOtXOvCaT19N4swYEKYD7oYgH
 sO8Uex//WyH4ox+Hce4MpH1zTqRK/RY+fkwnxSuAL4dwaYwEMV7NT/A9XxuwvCpYQNZhBOHHZ
 4ZjtfAGt8H8eO6U0MOtxESwt14pIsNtMAIxRADhoTkyQS+nlpX5NggRDwjfcIUypXyX4RYONo
 gLTrgvq0KtjgjZjWG/LUJI4RywFyBeWvvf2lxeBGbPjBhhwiAoEL/ETTEhlaYKUFLqvoPvMZe
 n3iqd9tuOkyGDcbw8md2MPdRFqaTPcPdqkPurh8LH0aRDPJUAsrFs7m9FhW+liGxSdVl7MD9l
 L5GunAiz51fzg9y5HOn46Hc3KBpwLQsXbRdcihBQrLmKPcuoxtrZLZuK1PxQ29SoxDVwFyYAd
 j7xoLXuxSgfbUNUaVBwc131BScx9IgORvMTu0nsUsoVMKuvQSVkTqNJP9qcHW9WAlkXP45t9r
 wyRQV8ytHtHoqUw1JJLZiRk3u/SM4CGQpaXuv+8ZPasAVuKZksWgChj7VLyA9FrQyZcm6u+gU
 t8LGjZ/jj5EO0jyKFq6WwN7X5oR9Gj2ddomHq47mLhqnzHOODBqRd43gNAb/bkfe4tJrIg3G2
 UJ3+RcnuCwolUphRccuU5s7g+qivubZBsDoe8q7hDfYqqr1EBk0WyJk4OoOr1kjAPLk/LnxdM
 Nyw+JuqnakBtL70p4PekSdqS84hgAIyeCK8lKgLyit9eXGFnsUlbRDvy9YkKYpVwPBFH9Db8G
 uqgu0SJJa3A88mMsqJYr/0CGkbCdqzgN33bFv4y1gdGJ3TLPm6d62U0EoZHXz+tL2bu+F9Ju8
 gl034i21H0yY8nS0R6zaBG8Gc916X5wyfrlfBYphv5xlGF87mDfdobMKLt9msn1jLri3mEaI5
 rWgs8lPwaLO26BF5Jw+Q0IR3vTfzx+wPVfeZkEfeRdTW4pbvpaC0ftUKAynFYb/9L4/4vR1vW
 Oz0jVKKXz5eYvFIM8/eTqC1Rk0TYS2wl56uKJ9pZVWO8RsxAWXu1yYK1xDgGreFwd+a+FQnDQ
 i325jy2F7WnxFsR7yjzyIFLSG2D30JlCsVukl52CqhYw2E8DjBg7fDIDtsr4zh0le2rIx3SSZ
 MT9MvmOCT2FSQTPaUN28tdeEqROA70Z3qMYt3C4p4mgD/8svYDuEtuewwpzpFNS1wwfC3UB4D
 MOEDXjyFCA8FueM5RdXCI+ukqJmqlWoYijB1UlpBTaxko94+1IQutd3ynX20YbkuQlsBZXPoc
 Frhz2rowZPzEO6yPmQuzDjM8cobJ7+ybi7ku+wy1F00q9HaJV7sZhvVeJwWVsm66eJu9KrVWx
 GRmtz1/CR3/Am3JtPLNZagwlNJcrWYRkxxbr3kpHwrV9Nb0oz1Okyv78EknXeXTHACugsppgf
 fB/7aLBf2BUUb2kLHjcCpj1KMjPblVleRc1JOTGTTLWGFKiFMqQ8k9nR20taaU1g35/8MJDT1
 KutTPRaac9+M+X7LLgOguvZIRTVBR+XN+yKZE7Y0iWHdDOp3zPhw1smJIRzT/gEi16i9WM4sV
 I+j1tAVKM2TKsEbmTMrTkSCpuNM0SySwzkL0w/ULsET9QZLR4iMEX0zyn9TTdaEQdbWpqP4yu
 sNM7nAle2hZQkZ5vLCp7E6iB5tI5XoRQwSuJZX9gjrDCiq8u7eWof0M95SkZNjRrZCSp4Ai1e
 oYIZTLLFys6D5HZldno8Jh4fH965orjlKXcPWWUCWIOZEa271Tq5VM527ROj80rxtLujQlB9Q
 2iJjokQUWOJM0Jw6LxmD67obicjw17XrP3DeVTpA80KovSkYQOEmZemPkhbw9AjmX5++ZPuez
 sZukN9zKW0L06pn4ZQnfLaVlHe+c=

During PHY probing and configuration complex configuration sequences
might be issued and firmware might be loaded. Hardware polling can
interfere badly with that. E.g. a hardware polling MMD c45 over c22
request might break an ongoing firmware loading sequence.

To avoid such issues the polling of the Realtek Otto switches can be
(de)activated with one or two 32 bit mask registers. Each bit enables
(=3D1) or disables (=3D0) the polling of the corresponding port. Make use
of this as follows:

- Disable polling for all ports when the MDIO driver starts.
- Reenable polling just after the PHY has been attached.
- Disable polling just before the PHY is being detached.

This synchronizes the kernel and hardware polling to some extent. It
gracefully handles deferred probing of PHYs in case the driver is
loaded asynchronously during boot. Additionally it brings the hardware
polling into a consistent operation mode for devices where U-Boot does
not take care.

Important notes about the implementation:

Realtek is very inconsistent about its register naming. RTL930x uses
SMI_POLL_CTRL for polling control while it is SMI_PORT_POLLING_CTRL
on RTL931x. Keep these vendor names.

These devices do not support power management for the whole system.
So mdio_bus_phy_resume() is not used and it is not required to
disable/enable hardware polling for that usecase.

[1] https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/file=
s-6.18/drivers/net/mdio/mdio-realtek-otto.c#L818
[2] https://lore.kernel.org/netdev/680696024a8648535ce6dee771fe4de67802e0e=
8.1769053496.git.daniel@makrotopia.org/

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 62 +++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 1873928b362d..161df1818d02 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -145,6 +145,7 @@
 #define   RTL9300_PHY_CTRL_INDATA		GENMASK(31, 16)
 #define   RTL9300_PHY_CTRL_DATA			GENMASK(15, 0)
 #define RTL9300_SMI_ACCESS_PHY_CTRL_3		0xcb7c
+#define RTL9300_SMI_POLL_CTRL			0xca90
 #define RTL9300_SMI_PORT0_5_ADDR_CTRL		0xcb80
=20
 #define RTL9310_NUM_BUSES			4
@@ -170,6 +171,7 @@
 #define   RTL9310_PHY_CTRL_INDATA		GENMASK(15, 0)
 #define RTL9310_SMI_INDRT_ACCESS_MMD_CTRL	0x0c18
 #define RTL9310_SMI_PORT_ADDR_CTRL		0x0c74
+#define RTL9310_SMI_PORT_POLLING_CTRL		0x0ccc
 #define RTL9310_SMI_PORT_POLLING_SEL		0x0c9c
=20
 #define PHY_CTRL_CMD				BIT(0)
@@ -217,6 +219,7 @@ struct otto_emdio_info {
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
+	u32 poll_ctrl;
 	int (*setup_controller)(struct otto_emdio_priv *priv);
 	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
@@ -252,6 +255,12 @@ static struct otto_emdio_priv *otto_emdio_bus_to_priv=
(struct mii_bus *bus)
 	return chan->priv;
 }
=20
+static int otto_emdio_set_port_polling(struct otto_emdio_priv *priv, int =
port, bool active)
+{
+	return regmap_assign_bits(priv->regmap, priv->info->poll_ctrl + (port / =
32) * 4,
+				  BIT(port % 32), active);
+}
+
 static int otto_emdio_run_cmd(struct mii_bus *bus, u32 cmd,
 			      struct otto_emdio_cmd_regs *cmd_data)
 {
@@ -582,6 +591,37 @@ static int otto_emdio_9310_setup_controller(struct ot=
to_emdio_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_notify_phy_attach(struct phy_device *phydev)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(phydev->mdio.bus=
);
+	int port =3D otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr)=
;
+
+	if (port < 0)
+		return port;
+
+	return otto_emdio_set_port_polling(priv, port, true);
+}
+
+static void otto_emdio_notify_phy_detach(struct phy_device *phydev)
+{
+	struct mii_bus *bus =3D phydev->mdio.bus;
+	struct otto_emdio_priv *priv;
+	int port;
+
+	/* controller->priv might might have been freed before during teardown *=
/
+	if (bus->state !=3D MDIOBUS_REGISTERED)
+		return;
+
+	priv =3D otto_emdio_bus_to_priv(phydev->mdio.bus);
+	port =3D otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr);
+
+	if (port < 0)
+		return;
+
+	if (otto_emdio_set_port_polling(priv, port, false))
+		dev_err(bus->parent, "failed to disable polling for port %d\n", port);
+}
+
 static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_pri=
v *priv,
 				 struct fwnode_handle *node)
 {
@@ -611,6 +651,9 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 		bus->write =3D otto_emdio_write_c22;
 	}
 	bus->parent =3D dev;
+	bus->notify_phy_attach =3D otto_emdio_notify_phy_attach;
+	bus->notify_phy_detach =3D otto_emdio_notify_phy_detach;
+
 	chan =3D bus->priv;
 	chan->mdio_bus =3D mdio_bus;
 	chan->priv =3D priv;
@@ -727,6 +770,19 @@ static int otto_emdio_map_ports(struct device *dev)
 	return err;
 }
=20
+static int otto_emdio_init_polling(struct otto_emdio_priv *priv)
+{
+	int err;
+
+	for (int port =3D 0; port < priv->info->num_ports; port++) {
+		err =3D otto_emdio_set_port_polling(priv, port, false);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int otto_emdio_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -746,6 +802,10 @@ static int otto_emdio_probe(struct platform_device *p=
dev)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
=20
+	err =3D otto_emdio_init_polling(priv);
+	if (err)
+		return err;
+
 	platform_set_drvdata(pdev, priv);
=20
 	err =3D otto_emdio_map_ports(dev);
@@ -786,6 +846,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
fo =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
+	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -811,6 +872,7 @@ static const struct otto_emdio_info otto_emdio_9310_in=
fo =3D {
 	.num_buses =3D RTL9310_NUM_BUSES,
 	.num_pages =3D RTL9310_NUM_PAGES,
 	.num_ports =3D RTL9310_NUM_PORTS,
+	.poll_ctrl =3D RTL9310_SMI_PORT_POLLING_CTRL,
 	.setup_controller =3D otto_emdio_9310_setup_controller,
 	.read_c22 =3D otto_emdio_9310_read_c22,
 	.read_c45 =3D otto_emdio_9310_read_c45,
=2D-=20
2.55.0

