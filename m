Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF74F30C0;
	Mon, 31 Aug 2026 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186924; cv=none; b=b6cqfC7pvhAvdK35j0wrrvxHeoAWzIoR1YHASQMbT4+NvOxsQlfKRfqBc4xssRYHR/ojcXgRV1qpnM9Fs8PmZBS/hUYvrWShEfUDDHsxd7cmJlCqOZNFZ0SyPnqluMhqi97WrRYCuLNGYAnoPcZi1BheTuw/yNbF9WvhYz8xtYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186924; c=relaxed/simple;
	bh=xU4wlzKLMXzW4bBRurEuRlO6tXoeUOa0yMEQfvCXXfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YojnUnxG0O5lWxGCdO/1KBg7UPhiy5EhpaTlXsXUVCDqXgYzCT+SfZTT8Wm65eL2vtuyS4RB7jsCoLwTZ0hD9l0bibGccy8y4VZfbJgySL2ttu8ybvExskaEaPFeUFuP60HlW10lQMXhAoFCctU1lfc9THAom2lHInQQTbmBCHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ot/B0yTJ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="ot/B0yTJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788186899; x=1788791699;
	i=markus.stockhausen@gmx.de;
	bh=0vk+7cGh1qNIIQ1AGDTIsxqdvqzDEgP1rmmNw8l52zc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ot/B0yTJdWn9vxmXJ+f/+DaK7S9grcw1COxxs2FtGuzONk/LL0GRuvGxsJF7QiCT
	 96tHtpDdFNHKu3DpOY6P/t86SWibTZ83qw7+ZInY2vV+CTDVjF4tcm5dBnGqsMmZy
	 autka3grX5JXTwVUJ27D8TyicIgHG2dgM2sMUEcaLuac6drFdS703ihHS1IJ37e+q
	 hq0bT/mskRICovP5bA4SfijcJX/RAFBK9S6JtA3xPJCIYNMwFpkEBjmKPrmkEraHv
	 jc7jXHnDBXH5xJJuiKydzpxSb0J8OdpliHLjk5rvNnUijYIyfBGTM140shzSceEJc
	 f6nC8VX8V+EkYzWjJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7K3i-1wxkFD0RFE-00038y; Mon, 31
 Aug 2026 16:34:59 +0200
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
Subject: [PATCH net-next v15 09/13] net: mdio: realtek-rtl9300: Increase MDIO timeout
Date: Mon, 31 Aug 2026 16:34:35 +0200
Message-ID: <20260831143439.2404484-10-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2Jc9xHeNZG/Do8P5boqztpJKK5WS6al+aBYCImhfE6UkQq93Pgu
 6UBf1i7bX1h/7VQepVnxWZ443C90K+hC85CWUSpq7eBtchNZDk5Ct2iKvbtxODS6SwRbpB+
 Ho0mqrT6SHmHo17VQ+6SbTfAWHuGkc0r5+E80ackIAsVj40SizJhVMVIAoJaoOa//VWzNSn
 oiKWdLtAg4c5bJMerNeJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4exEDfHCMxs=;iSUeDjtoBuqbxOVfGy0m8k0JouW
 /0w9a5lzlVzZvcmyrV3cvveVkDXdl22iX7UNjLRptbyUVWpURKJiiPR2CVwdkn3wjdC/XWcVi
 2+t32iUDyJ0PFlqqzstn+3/sKEJOuhDIQTkKyxNxMSmfWiXPR71d7lYgDuZAhTXoy4Iya+hvh
 njyuiOYCFZ/oZzoSKQGZ1/+DXVGvLWU8QuRjaecFC3hH4xZ4Co8C5AwuOmyj3FRS2pCS+jn09
 awy9ok2/BMcQn86Nepop+z7MuYI+sWsz4hazq7GLw72Mf91/hdMiP/vhjvgOo0dGAXrr0uzRF
 9Rkuz1SzbTSybAfOKtIMxcU5QllW+k66iB+0jzGN8X3dzkYHDFtZWIlstDRKNw+o8bopG68p7
 /YrX0fgiGEJLSTZhX11f2ZhPXMPmh3lffX5Iqck5laDYeiRnIvjZIHUNCbuG7BYRjp/QSiRJ5
 R7xOqYQa5bGFJlxSYTpaDKYemcgBli8DPzrHKVisCRLacwGMGh3snMIkNPl6DR4QYd9JI/qS1
 tdOO4imt/18SR6IqyZs9pbIUrR8LpfCYYf9Eg426W65mDzOI+i7mnAipHMatOeYgTnwZgh3WT
 7k05Z6lXoSDTjirbPmfL4HZiaTIHTQfO0AeE1ljM6IWPKtcr+VZ6zeukr8qei4XhF6Ru6YFVu
 zwFe/NFbBgh8cdJyfqUqhR40wk6tZPHVEMOHyFVjP+CBvk3IbHIm8ToWkEwDIJ/7nZ+ZkyIzX
 fiXLwjqYyHdKhQ0OgVSb5X77RNnyHwKkmQ+kIzIsoTSE+sUs7Q6VrEmQjvqrnmsFy9UsOShjC
 ccEn082Mj5rxXb9gZgRHdtJ4kisklFBUZ9BwRpidxJ3saPy+3C0Mbf7AzHhkuoxctGjAvtDZK
 XZP0UoV9r6+xdhrbY6u65zby2hMLQR8GX5Fgj+oaNeDtVwHUTkne4JlZaDmtcy2dgGJ4Nfrq/
 tPbpDRJejHnDEuPmz58YI/QGsg2c0Glx+GkHbTYdcudqDj77T0sxjix+8TPTFY6J4i/i4vID+
 KHT+ik+ive//Q+eZjTKJXrjZF+S3I904Q3NiLEZ66AODT4ExkMHLqzi0pFAWXjpbFjfUsjS6Z
 mrfGESxTQuQ+ccOBMzKkTORYc2fF51L6Qjiv9k4XuVpsLuKRB5vPBD3DZ/+q6TFezk/n/igJ9
 gKXWXuDPELCTNyCTAkRsxG0FRK1XfRMJZEP6Dn809ArgDcSGLJQlTbjcMy6HBEI8ujRBtnoip
 pp/Eu9rAyTGCESNE387f4zp0Gc7TBH3dJvpgAmIC0R6zOfz78Cb48r0S4LGpLZC/uDdUDdMKQ
 KhHim3wMuZSQ1GaBRxKcCHGKMAydPyXnuICStCod7cJKNn/5/tsYzlVq9AJ2UyBwOsIk1ReS6
 eM4pHKHDrLL8Ret8MZ5M2mHAZhg1RpQnsDr6Op8O6/A98O7+Vy0fGKcQW45/VA7lfWSQA1qMa
 HMyj6VT6jjjMFh6zvdf2MVEJEFUyR1GN2bRHErh36omJQZ350GtNh8iui4kW1Wlg0ZV0bI7Kh
 fkhpubogIsHgKofD5ku1JFeIbmTZ8Z8gyJ2DpARv2R1q9DJXUdLGDPD7IsU807sNI4jleKe+H
 Au7PuYrEeGdUfjNleIfqqosbc1vbSmTKUP/ZxY1HCIWIDguOkF/iM6v0hRktAgO/m7LCTzsiM
 mN+0ZAxcnaVgzHdrve3UjjRxoKLWPmBAQdARV4peB2vj3j89kwH2+OOwxse/1rK44NgKiAFIe
 EbKKsMMAfKGLQFuOkksN5J3auM60fw9NSn3UF6B5V6V/cQnqpAZe7NmkeMSltbDLyso7xbmuB
 hbi5XyJxJM34c0wPZM0Gl7nqVkPDQk8f2cnqvfNjgwmKgWudYPzLKbpLXEja7qGo+I8Ks0dzJ
 7AhVEOSHnbviin7uXB9jALSRM6m8jOz+EbfTUTMkPu+ZUL3MxkTRAeFLbtkgll7lLch9kxXdC
 lSzPBCEq3MvJIwsSFtIf9ezEZhGHwwU1n3biizNOIO9337Jc6N1FotF6V4TRrSEZMToKnzHHF
 6sjM3XkGWVcDB18tAsoYR+Bkx9jLEMjwplJQvZ07m8CHGmClXDtG3W2A/HiPyzUYCoLBRZ1fe
 48OIsZpUqDY0+4Oip/ycuzVWEMYCEa7L8i20RMzFMMQ78TnnxWG/A2c0wxjjmR1KK1w657tFI
 WKKLRTf5Fo5T/aYPdsHO/Goz8KiQifU5IZnJVZdAh3TDdxHRLJrcD/OEyXjnenioPAIWIKH7j
 exzSFs5He4lJsiQ0TXWqc+60I7o0+lPvma7s7qyLHzkeRlLdplXXKDNkmjDrEklVsOgOX2Kh1
 OGVxD13mz9Sa5Jbez0F26fjV/v3Oo6KQD3elAM2tMP/JEidyS/8j2mMXx/NBcTCPedLQxus6Y
 LOgRgUS3AblVmRf4/EX6+oHUM04XI8LAXjYPYwK1cQiHZuuvdn71fHzVHbps7mN6axkWL5p6l
 /IPxRQ/n/8coj0vrjvtst0I29b8NZmEc0SNYGUrgIMgS4wr9E13opRa3c892twJhUSyzX/BFv
 DLlIiokBMTEOUy3peRPdxl3oiq/9fyN6wlHM+vjcVxH0GyXnG0OeYupY2IPdKuPX+6Y8GmOD2
 T4B+3EKIlFhhoUk1srS6ehCtxJ5G6jRYW5WQzIUtuYJCAADi+WqBOREildD6S+sEBlvsYtnWj
 kbUVTVuPtNZ666DYVqj3CxuLoMEhUVglWjiZaXE+Hyq/E+DH8Tb5Ci2xyF2D6SSOWsAaGC5nv
 +nT/LMqvBniZ6AootwM9W9/2izsUn1hgIJpPaN2QKNHlCBIbJcqza+D0w2N3MnDDw8wVidQ5X
 ms3m09humENgoKorLhzS3n47cF3h7LtvyouzHRfX0tFfJ0aGUgjgLFGZIYjpgYsfHKlSBFHFD
 gMff+RoPwjia7DDM/WvH9xmUclLxD11cAL5LxFVzpa2ehityvd2VrFe/8TISsHUEq6jeJmX8M
 PyvpKJ1CJK6M3Db7FTdK7OMvJtwUsEVqrKgexeCtFESmN3R22DwoA+FhONFfaG1Qhp26uZA1L
 +j/qKCUMNcyq5EstMMzmiDPo6xHyOMndtpQyS0QxR5EDQr9zy/SUtdNeh9OdhnbuNxNuK/s0I
 02QuoHQxHu8C2GGS6VCliybz6+vTMJNAc6PFxfB/rqL6jRx4o9Os0hgmBLQzFS+1muEG8JGDE
 peSl/axBHLNcZC8GtEWZABPpPkopJE0UkYwJLyV4FeFzazV54t9BikOfFJ8FMzxP7pmAOyJYD
 /ifbMFAq1NCZSxWiuvLLTzP1+fuZxif1kbyTLVajpyeFKbnw/yk0EFhLzKwQy/I0BuORIS38T
 nSkIkMn3Jbt9d32RqfSbKJCYiPaxfQjJSLltXCV8t398xOgDw9NCtkmmy7DRNTUSS5Z5g8FsR
 nwdKGUhkwKXZlVSDitdOK9ZY9ATrOS9WGvYHyZgfAhFSYZYdTQ5t8FaqMSvf+vJZSznas/mLf
 75zrIiADTDpD6euU+6n75uUEyaDVZAfs/NMlJ1/4BUb3tOlimdNJtCLSKaRAnc0EhHxljnoU1
 Vb8XEWie6pjwjy4vHup2xMUjk/lEGD8X6e3eAVPv9LJ2dhJMbxAaJNxaqrc2quVhHHZ5N4lfj
 XIcvWbObUBkeyJngUXO11KHPxppyU2C4NnpMolWUV0iNP+yZvsBuz8l8xgLo8aW2ue+WcKhNn
 uTIupE7Rp/3mIeDAH+24rKluQAzcYDRsnFhhyp1EG1VQwYOAYUHOiaslMQwTBw6ZIuP0hViOy
 Z0jpk/f2ITfCNZ6Y9hZNCjfJ3DjzK7iG//rKZLMU6DtN3s775vcodAiSWyxbYlBoNpWohtn5Z
 9TO1/RhZYaD6Tw+SPGYGYX+rthpjtXlnsYsJNsui97TkyOtjbhJQ77EOAJ3IJClWcqfQrO5K2
 mdrouPLXVdJASdCziPHx0IuBVIhut6M02XmMrKEoPUWMER6KI7IUPg6EEJVA17TyHSpmMcBvd
 skdEpkmDPXTzE7AgaFEakswrZUeI4KxmRW7lXW4FLnRwAav6T9IX92fljCGqbDzcPO3Jj415R
 bxqhiZ5nr6LgtIppSvPb4XMtnjOBwh336JvzGQedSQsF11M1qsBmBvkUVISFhJLWrexjaRxk4
 /Ug3lTxefGkDclqAsJLaVnyDnv3DNnPq3SA1A3XEVtTdxWDy98OrW9hKhf0qt7kd8sAUICEJO
 VTIHs7gO6Sx5nKEcDTd+C0CH8YX7LAOFuiz68cyk3mscYtcaRPUPdU2ilHPXW9mmd4iNteUpa
 V8AwEXEoTCUekG15q4dQMopFosL3hRGVyxfIZW5aOii0Lr7MpcF8teOjLAV5KdHrUlILHKPLu
 P2P9DOIazXp7Svh3Ky/PnkYntmhCuHeQ7CO0AoUC+PaIzT05wyTbwo5KBrRCn51e1/V7SQVvp
 EYxzeUhClUXevmUcev7qB8EI4qxAWl76H93ZHCLbapy6fBt0A6g3Nu9ClAdGw7VyELhG+RzA7
 SzxwB0q09lGe7FekuvewCuVXawB+Wy9h6FUdN/93aBbQMinA4VKH4I3vAxQQU8vyH1ySDNUL4
 7CJ0R4IlT9Jk60YZ1we9Ii9LvAeWDCanXfGZuMszQ52EghgzM4eWQi7yM7p0RMAUJp/NPoJ8o
 VNj7z4OvY7ieH06yNouN6DkHKiiigVSsNWLKYesD+bJ+ePONHxl/ZpyqvqTMZYWaZignSTp3I
 BfetaXjUSfwmIuTjzZb8DIGL8haG1re/oy4UCdarxJIEOtvujsIy7+ERjLaaL9+tm8/2MMMao
 Z/yhInLki+CelvdUYi6YF0LCRWZ0yNW1fXA5hPxmbYDdkQg44R7MYB/WKYtzbQXRUjiWN6WDA
 Bk8nmMlHWGB8PLnnR8zR9+XKoXMVRRBEtLWDXuV30EX/St+AjDduqyAtfT7RzCRW/M1+HIgZ/
 okt5+p1DNjPXkSstZRpxCnRbqNdFrCDHQpo+5x7b3+o5ToIeMnrykRCdRgJ5X7thHbiZFEjsc
 CvJjurHQrXzSCAcSPhgN7on0UwLuE5hChRsC10FcvNOeGYLj8BiphzUqab8AQA7vFg8BBMl12
 fclXpvVQP6CZd6VJJVWOLU6QRwIDlK/t+Nk8rejKFH6GO0rUeFnf5E/EKhiQzTTXz2GOwT9U+
 dCoJ3HuyhdBE1ZsBGLzAyJi3byXtIGM/8M8EUzad03qI4/ICr48Ke6ruvhUYTPenrV/05oPrm
 wp+VaqQV6pvEUxk+26+kQm+UQoU9Lm98dWTegnokQ1+Kb634ZXWY2CsPqxPHRStoFomo5c+O+
 fRieEqCgx9iKCTtZoES1NFa7/aEzIjrilWa7UgTbIKe9dmj6nqTS/MyZk7T8/byLhZHvhxfCI
 nyhCaK5YMJiWBTuqN8Itri5ORJcv4qIqJkhZGvz+bZeti5fpYejEjDpaLa/C5iirHBuMp2H4m
 Prwx173m6V0gT5q90/A3yLouhjTW6QHkUYtbe0V9c63yup37k3cRBNlxxlCvy7jWyqlEjDqyV
 DUxzE1PtCXYNlP4z67T/4uHMGabrlimvkBc7ehI+mFkr0egvXBZiwRiG5x6t4tu4/LJHcdgLp
 mQYD0HP+uWaGI+nfPpCs7s1xXBLcgXTdn6BPtJTXGCy1DOSfrDb5eFw6BS3sL4DFmuYJuAEM1
 qtZ7ggyHp6B5RSGzwl04UGMSOjqtW4GjLtxRzeksF7DO8yY0T1qKRoJEqeXT690SZLZ7QjaT8
 w9lZjkuF1L4bKrnA6n4t15mpsGK9tV0TZDGk26Tk8iOgEEWrDj9EJLwreIJRwCZVm2wA3MnnQ
 EsKMn6ERSWRkmzwdbieJP5J4DRW3g01yXpJyTNRos08mNEpeEGxfSDWNHN5tNA1ybU3BNV7Ou
 SUjc3OPiAzhH2UTtKVgwdFtA8cu5Z9xeAx+bTW9p1QkBaRLz3k78Ui22xmg6ZvAbZYqvtT2px
 0nDK9a73EKLLiNcTqM4vAIsfSAP5kQQB4kjGE5OJTmMXvG1b0egol4Bw4kL5yaon7gaTbaQbK
 LebXwVm8GUvPPxbSVIkqHLqtSdha/eMdA8S7OjqsTu6AmW4WkZXuUhCpNPAzq3j3RroVXao3C
 jK3lPuxZm/5E7QsuiZCcnN3JYNeYcRhrZoQNErRupTioWcf9pXzxiz5C1T9rHqTadKvild75o
 Dt8JBJw+TwaZTejWVUmLsXqDwvRUUkNwkNGJt4JGZQf1g9uA7oDsYYvd5z0/CjTTWnROEU1wY
 kB6+i1Ul58kO5Xg0iZr76sgpjIqGk+qvhC/2xGtuEgD6F+jBhUwhpv7WLc6jcLzJnBMNRZJs3
 ITpCzKVQww0mS0NuN40hlGxOVF71RORV+khenQEdCzRO3wPUyGXZ8PM0RutZ+lyDY5GcCNqT1
 MgsxJeVZf3qwLpDXbkKwNJa3PmcL8/lZP7cvL60tfhRYQ39J7Xxt5ss7PUOuJJDCVZQamVfv1
 20WYDYvdpVdZoXcjEK2xJIcVxblr4W9oNvEBme9IaB8f3Qoi+aGkxsXoulac3+mxpNIjkbFOy
 zsR+RtwggKFMag5tr4kqRNuJjou4fgnEbCtb+B4cCG+jBkqHUkFJZI38Wu1qNsm1/fu9o4U9z
 /FPp5iATt5/tq/qdARpAT//yXPZ0LeMN/pktGSu+wqxs6W+pWIpp/mUVYtVIDhllWfMwTj1jq
 nJlfnbp7AkddCtZjVG7aE8UakqL4ZZcRikfdgrnHD27kW90Fps8J/7/U6qO0sBNtt7cb8MRV2
 ev1c9fK2SZl8c034Svr3WCDqAyzZu9+sQdq89AEBzOWYPho6qARstW6Z77LovGnj4uJnrIb6H
 ws=

RTL838x devices with 28 ports produce PHY access timeout errors during
one of three boots while waiting for MDIO command completion. This is
currently set to 1ms.

Background: Access to the Realtek Otto ethernet MDIO bus must wait for
a free slot between two hardware polls. The polling sequence consists
of at least 17 commands on the RTL838x devices. This delay can be nicely
seen when disabling polling completely. The following times are measured
on a bus running on the default 2.5MHz. Time measured is from the last
register write that sets the command-start-bit until the hardware
responds with the command-finished-bit set.

- average c22 read with polling enabled on all ports: ~380us
- average c22 read with polling enabled on one port: ~380us
- average c22 read with polling completely disabled: ~180us

For this bus frequency the bare hardware runtime for a single command
(32 bit preamble + 32 bit data) is ~25us. So the hardware adds quite
some overhead. On top of this comes the fact that the RTL838x devices
are low on resources (500Mhz 4Kec core with 16K cache).

Increase the timeout to 10ms to be on the safe side.

Remark! In a future patch the bus clock frequency will be made
configurable with a minimum frequency of 1.25MHz. Setting this
(e.g. for debugging purposes) doubles the command run times but
will safely stay below 10ms.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index d6027062e452..ae7ba86e90b9 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -274,9 +274,9 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
 cmd,
 	u32 cmdstate;
 	int ret;
=20
-	/* Defensive pre check just in case something goes horrible wrong */
+	/* Defensive pre check just in case something goes horribly wrong */
 	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
-				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 10000);
 	if (ret)
 		return ret;
=20
@@ -316,7 +316,7 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u32=
 cmd,
 		return ret;
=20
 	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
-				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 10000);
 	if (ret)
 		return ret;
=20
=2D-=20
2.55.0

