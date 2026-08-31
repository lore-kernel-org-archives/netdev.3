Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5004A1DE4;
	Mon, 31 Aug 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186901; cv=none; b=KuyAlIMn7z5JtXnFQYPmYzjgsRVC/MlrZ2jWMVyJfxVYf7f3q5aYVMQUQMYH87NkF7Kv3M71i/NUdhRW40yrbl/ZfpfFMzLW7n07oesfUKYHpws5hLC+0fp9+OjPNDIkQXekWtxXUQKZ5zASxApS3PKEkM8BCp+iurzIV1Vo4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186901; c=relaxed/simple;
	bh=5/lw5sZpsLyAz1JRaJWSE71skFZpQCmTU0OmQHURBdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Du2W8mXoHkqJlepAMH4oKmSjA1StVSnsAz+WPzWYBMpEICTDm7eViXO8/p0RTqxlnVwa7cCaIQl1mxop1694hxlkov9VuGlGoBCBtnsMZImJNCyx6GHUN6fjGW6LfbIe1QeuZeewtdNgB4m/qKmWu0RvaxERFh3ix5Y4Iwe5UW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Hy/SvMFz; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Hy/SvMFz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788186896; x=1788791696;
	i=markus.stockhausen@gmx.de;
	bh=7Zitt/SWRk9KOmy45oJeGbbCVQyAHJj52bKEQEf/c78=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Hy/SvMFz3CkjCLhpCuez71sQLIhGzjAB5PoblUo1ZKrvrIKUR9JfKOxHkbjnAYw1
	 JQkgC8NZuQB+Cds9SBF0lyEnyHLpAI++R/Uluy3U0B0D1sNPmwhxUtN2eA0UExa28
	 f/1JonCBN+oXozfiqr8yjkNA0qy7bCu4IB4t3r5ITNBaOtxYhrXF8UPOeHlhYOaCd
	 rWgkGGG3KXO9ctElTLYpde6k5ugcLmUcJAcXP1ROvnDcsZ+bBsYXOp3uvyx5puFL1
	 DtdtTCgYdprDD/6ND8VQPzUAT+FCYFTWVYRYTHyw/BrxspENB8YlnHJD5YdM5/k9l
	 gl7pX98lLJlAKlpF4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b2d-1wxT810x4v-000K7t; Mon, 31
 Aug 2026 16:34:56 +0200
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
Subject: [PATCH net-next v15 02/13] net: mdio: realtek-rtl9300: Add polling documentation
Date: Mon, 31 Aug 2026 16:34:28 +0200
Message-ID: <20260831143439.2404484-3-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:x3f3KLdSL/y/Z1BEMVwFER7F18DWugQlfQ+Ky1EFYgOh4zh3aaY
 upZWooSDzygekfpNof1uo+I84B6vZowdruFygOtHXs5Ud2MkU0WJBB+uZ4cRATYohM3U2AT
 ny0kVvI3+rVbKt5F2dZxNKjH2OsS5PnhAFr8P3k1yVnmD68oaCoJAODnWhzcuFFCM4JwnLt
 TqrrIxd+RcGFFogG4B+mQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dxX24UKf8Uk=;wVd/Vv8MTPeMUdzrZ6L5r6CXkGw
 CwhWU3wxW6cHLqMKwPnMqZWjywoCUfbuvBhx47rVYvdaAzrZNmdl9ByPhUG6tENfI+dDwivpU
 woWDURxc3+pfF/r1q5KE24HnmO9D8/W+YjZdNBBQmykA1irVtNHovLrDsg/P0ss0G8sCTihoW
 rXoigPC87EMVJMK9niwO75747L2TtQ+MCeyuAzy8SR5RJdVmjYe6dojakWzAP7wykBtBY01Pn
 PkVlTUxNATh9KQmEGQRn152XgJ4goniYYdpdDiYSYQZnWnvzGSLyFl063gNGbrKFcxh3jJcFD
 odj7upapVnyYFPQYuXq8jBx5c0EGQYJtsEc6fPRtNlJumCPNduuIrAnBblRAI1G1iCGPtHCng
 Ks6U7st2Jhze1Sar51iRtxpXQjkO+mJqdaQDmkrTtL1ZJllvgCqumAdmYWmL8VfY4kfnBqkio
 mvniPv1cFYKBdoV3T+ZlbAaguk7B7hf6c/+ZG1EEK7evWgD81x/RRMqbugBn0k/QIYgCAZU7N
 mRSq0BG5wUWWUvl1cnIO0EQ9iesMYQ8pYSipXFiQzJOQUqqL9cQ//+UysA4DhILT9CXDiraVO
 HfH8ypvg56Gi+TXLOKYHu760dgeLAJnIGLqCPXjLe3b4z6wtLfaZ34ai+kwdozpmV729stBDs
 RQtsYh99J+r8eN0SPMUR9CF7fSRTUny+mcAcrVhtmrrjC1r//QJGLt4H1TtOMhP0m6Mz+M7/s
 jOj2c3y4p6vplVpm06adaz8eiaPzmCgNaFLkzTMgm1kc+3gd+2Vts2VqCPU9WJ1oJuMUOCu4p
 hPJWmmGvyhVdaOsLY4VaXRFBDPg1i54lx06Sk3ilk/yxDNGXfQGzBl3HFMShqtofV4sP4sP2e
 8w5/eIiz5UQ1/FknMsWIYjvBwrR8XFLMuCqTYaRn+IlSZbxefW8wkdSmdbQdhPdNaUE2VFoCj
 8EMf9NuBs1FUBZE3ZQcZ5sJdvdaoSUobj3mqsbHCqOC+KSSRjLEEktloFrLEozb/hJeYA2Er8
 ZWP4z/KkDtb63Sq94AovDg/ugLlZM6ToKhMhh8OzqePGW60osu5pEjXG5fvitydUy5IgYssoz
 8e+4jZLSz9bD70pGIvV+GvqI7AxxU4Lh3kK8L9ncgAfIKyGfdYZJP4qGV1eKVsh95Em4ggzDV
 sBVy3iJBHkTqiXIT/Od7VpN4XdQoyiSn7d9Rhex/YTr7/AjeaKTRfzD+xuZugvCVj49rSetoi
 8h/hF5h9GR5EAnGL7E3/1wVNwILsqfgoFvEFFLYzhg8PJyDQlzDrcEaFu/i/2L78KBiD5iCU4
 swYKkUIyIU4eSjTb5UQSAlPS3dx3vtQG5nmWkfYLU1dL2AlIYlJAnc8Uby6mIHChdjkgs9Aib
 hhQyLiF6qt5bbHGMCB7eO94LOmQDA6UnYJpMAiRZ9dKolvfc5p/CJfACWOw9XCeB4os1KMhc/
 S0/f7Zg/n21HFMX9QMdtXblo9LkBYG87FyEYEefX9zWJuQkP5rbymyMJH69nAXdMJCAK2ElN9
 7kpNivBG35fUL8LuN1ku54loRmoAIPGhEq3Dgyqk+Rs4MRRK8WwPl78gHGatwixtm5UXIrVkc
 f4wnziLz7wSFOjB7y42dknyuGOuPzysiYl+RowcoKc7wXViF1m5OSz4mD9kfS5ry6EPsM2R6g
 TXb//k20tOQPtHFtZFymrlgqkJThqiNP2+1sZzaZ37150xdbmnKlcFu2gPp0ZKpPy2D9pRHp0
 LvdW96Dx+IhAjUtDYHANwBQkQ/7kpYv0z3A06JWRWd5rX+6vcFR8zc2CAIt7tpFEKPHfbfqAU
 XgfeDlQ7u/iILs+vVqzbqFW7YYspkOFm89opQOfX2eKtGm50ztdMGpAmtvl58w5jzpxnpG1YP
 IGk0xii0a5p6zVOFQizI4eA1NahAsmzIpbUF4WDHiEtAiPoEzdu9jbl30m/ILtgV2N51HI+Ey
 IB6gsRuNHe9ENen7xvBhdG4ZU0nBdUP5W7WZvse9CH36AUhj6TN6jbOPY5ISJNB3JczMpNhrp
 hrX4njW+eyCjWtx/itjgKqEjA58xsl5K8mRP3fw57NwbiV59co720IaA4uSS3V8OVUU5mgbWn
 OlWhjRa0eQg1NSill43JFt8K2noVknR7WUJEW7oQVDFgmn9xDWBI6ooM/XEK0wxH7PsgkaZXa
 kxYQQx1GCbco6AaTrqjO1wq9+IG+uVEXl8oLigq25SU3uPCtki+DrEUEKEh0sDNXji2HtdEYf
 RxRBFpC+5RkgS5K3gYDR2dzWyNKYPGbFjOek86H9KzRaX4YfgYDzqaOJOJbo1x2ELfpB+dnKa
 HzGh2t6DZ8aIL4HP5++yTnGG0jXRrZY1c2YXL4dxRSYxvdmK46mBpDXC/PQvv/o39M0qTlzNi
 Y7k++9fC+rLoI2O7Kwbuw5mGr+i7p6ZsIqELDXRr0mgeksBZyy7lkgSm6iuJ61FEX9wsWAeF2
 GKWuu1YYWSrGOADKsv5fh7t6zzlYEsQ3d2TKISbLz/UVqGhrD2TemMe1nrFq/qvdXHX8qce11
 3yNMQGlRwy03HN2gS4JJXlNQlIGECc8YgmxraB2I1gdeWxfHsTch7EojCQnDzzjXXlt0Bx5sR
 fNd8/EddlVYHgIa4DrcdagEST0wagCavNkPoDSUdb8nwy8pMonMY5z4ZdSYdPn6Ten0IDcq5g
 BzXxMliSbkm27XKy5UXXJqG4EDQ8iHTtPT43nslCqaQfB5KpnPTBl9vdmwLeqmBIxk3xSRm3I
 vvvkJtD4NKUfBWlKSLogllLoq36pUVbsjGBBYOFeNnLZ5b/oDqyi7cw9fEej9hDD2lQJwQ4bx
 vkDEYZJmdpaFkVGOKktdTMbw5oaa9+e7OfaUZ5QuggzPv9xgfgVrgjKJysdM65NQBtb3eU2EC
 S/YZq33am5ZbWScTyp2RWmJSd0P2+C5JQhksxhNZMMYj1sItI78jlfVzb0RXSbDqYT3fubOtD
 WwWJcLBe7Qu9M2+nzyWg69y+1/gLn9FSK1gsbX6O3oNozdu/h4uqIOBU5JqDfLCIC6t67rFz8
 FYnPwwFXIa4vpE6a2NhUUEV9ePr6ouP//DXOVzDnYdYNja3gHdhV/0w2lYGPMubzAqXuxPFcg
 +RAH+ek5uc0HHPQxpUCVoIdmuXR47rklhllTNfyU5TyUSAx6GDw/01B0ZUa4UTNyv8gZp6F0I
 FGwQ5noZ0+4yrRWn8oFr36gE7DLoerf3NrlhRp29so7vWa2uPB7FqwshWSmpG0aQF81a5jKqE
 Aty67jzO1iB2KjHz4CsjXics0hISflDw7hVLKvs9gG3xeXFkxSaGHWzCt2//tDIaD6Gk5lK/q
 vkkshCF4p1DmTCCsVZu7kMaFKDaaPeGdjxo0k8d3xXWlUtI5ICwGHJGnXolngBJD9hl8iMuuC
 ao5883l7qIgccIYLqBZQC22P9oQm9D/zzpEAwDgPPwy/PGHWN+YorCnNRDf1W5h2sNXmGPlKL
 mlpx3N+131pK63CV+M2rPW4SLlj7SlqmpSLIiTx0a5MkhElD/efX1J6E9EYh++8He4XDwvfKk
 L+TZrV0sIxcKn7+JZJT9Bj/BRYxB4vJmaVaiHC3Rygi/Qu5E2M6KyrsU5pVKlB5n8FEJ+PIir
 ceUmuq/cQvFMBWjyxsaHgXzkFQUMJLQVWExkOpOJoqewR5XcdIYcuVaRMazjXCHdkdWOsrGKO
 KgGYQt+Z4/ItBIlNKgWp7fOR0ZZ5bhJ7NGfQNvt0URhZmjbgXfV7t41ymliDVabKRRVM/u95J
 4qq1GX9c2pNwd81PFznH+UQRZZiKi2cVEbXfFbGzXMGSW2zTk6jeBAOYE86hdqvkcMk36/GJU
 b941EiHykuLTeANQPFi2U19ZFt8sro6mCuzvsriu108+QAWL3chOFGRWUrafEouk8dP4qQqFu
 LVUvf39yiTi2hJYDCbSpYabk1DOgKFZdr9V61XKJ+/0fiMt4Le6t95Pcwp2KUtdGHs1UO7F/q
 NCYjmjUpN9n3a3BmnapBJa76UZoiHvwWpUPMyO4wTbmAf4Dq+2Z/rxoTlcF+I3r82EKeIgD1G
 Hxu/A3G45SCbV+uothF6cBVQsdv8BJcJR1+lfZVkMEcFHT2vwt96lIUxiDOJZxBE95Y4/s9aH
 dg/12pLlUpMGuocLJYjDXIuOwQYbZGS/dt1MiCFkdhiNn0o560S5FgQjFgKcFR9MDsXIu250w
 Ju8qH4eb34I1jmbP58cFyC+WHTUTxEsKlobvkqHqor5T9lClBSH5FP8jbv5r1vwrD7/Ph/cjn
 5868t/J0NcHiN4joKZ7tH/GDDBG0e0Vl6U7MQbo9hq9lANUE0zljzGQtt76LiecrVVjQdjpJc
 FNPGAwSukwr2JeKt5vGzlcQDrNNCfpUfr7QLTTCR4Ndt4pRpzF3ZjjkrRPkEWQF0ocJOoQGrV
 bk0T3PmOTrKegwcWLFNSKFzGi+hzFIZdnUbarJiUNtZj5BgtWLYZO3ielIX0TxiY5y8mNXaYv
 saF5KXewU2NquvyxzXxQQrusc0UIRBSMyv+ukbSJ+Jt2NlB9ZhKVIMMFHLMIgMSp18bKoA4EZ
 EP8GvsL6L8zg7FM3KwaGi6BMgrUg/5hVN5j1tn/arOZe/y3SOGClhCz3M+pbWIeXZewVkkJ3u
 FiczFT1B6GlE+CzZT42jS5VUxTy4GyGqu+fP/FOkbcR2yjhv/lSLhlv6QyMMuhRILWjke96Ja
 6BioWenCoG8jdmgbJZkt52qEw2nWzmhRvjOcONWTqxTJD2LovjI7yYVbzHml4uYqfzjk2FUx8
 p028Jx1hk3LPuSvuuOclE/WRBPIoabjYgVUsfjilWJja9LKtTbICS8Lv3U7LqI98VN/HK8VLk
 2EmEv3B580V547nflIWntlFYLUWm2b9tnI3n2oSG3RMLEzF5tnPEEAZpubYXkU48TYtbHo3aR
 xthPy23K0FhbInxwaRQARBtJ5sAvYD85bREbpPQxbJZOq3Y17+hIAVqjw2qQ5fFceQFu7dU8M
 2UCYTQ9K0XH8OVBuR5U5Db/FdDZiA7wTeG+fz7/TEtB8k9ljLtebPgqSAnZf3DnXnP9U4D4Y0
 Tt6COmEuyuhBYGd4ziLixgvbAuEaMwP2x0SOif4Htvb9nGQCxT05/W5z6qUGZijoxBwHFiB5y
 fjKq6eSSJXLLWv1e6fSfxeoJG+/QwaVAoIYvwxtZWLzkwJW+EyGcZSef7stCXGGtKyXLMk1dZ
 DerKC6JHvg/gEzshMnN+8bhym0FfKMvlz2jseuojxr5cxwQcPaYinX8cgJE7xf4Ft5/l66fkD
 Wa1r5szfnt6hyE4yDTZob3CIUsIt/IQI6RrZTdRHrC2FsYFr0gwehfboT2Jzyn7SlEEtHSVSK
 nNUzmVq5uR97YwshvWftAuBtXWYGn96s21K68B/jmZtGIsEOZxSa/rUlXV2TBT9QgU5byg/45
 YmcbI/3UjunTCSkq++prDNQfhmNxo4eyCr1bHqZpYEEL2ojUtuw2+XTzuOLXCVdy9Roye7oMO
 yZ5ciBY83sCuNZFZjtFEdHdBuhdd359HToq+c0nN2LxyS2QzMcNcbfILyshI3twZZRX9+4nCK
 CBmd0KhmDZ8pLhnhxWZhBspj3gFA43mTJJA1z3NAkrazJmCC/zyp6whICQZ/fBxjrkws3aeQ3
 wSGcKyAL24GLUf+Jihxh1dTr5glVf7KXPGcF1TPG/oU8J/6HusYPdhruvmTRO+RAlHMVxr+gg
 +yAP0t52SoYjxYAx+quHN7pzdobOjk4eX+blwoqv2miuRQVe4P1tar7JgHmCA1c0AnMX4clce
 65R8BwWoWWe7eLt9l2c/QwuE61Bz6YY48K7sPJQUGJKsD+jsv4Y12RkoMN4qg6rqO7X5SUgZg
 K8XTVmXFcYRYTksIoVIYkQgqJz5xnzBvJUmaMaZAnuMGLSJgFbtERtcO6hU8H+p66rFiB/7Zn
 7Hq5pSlUeCH103zeTSP6Nvsot6npkV7gAOfjbmUig6iJWaJudeFumV+2lk+1lKYJUtZ1Vh/20
 OfpNtGmJi3EaKBxc8W0FOYi8j+KhwtRbNobzsLQhCHUN7rG9GzHJL8+jSsCMV55/QXT87QVXK
 JubETRKPKplp63QAUG0goTuOkyULv6ekZh3w5kPhcRvcHO0OoJWC+a/Qgejg/HeYjptgE1E92
 ygXm/z8fiHoSATZ9LqUaw+C8l/mJKeH/2n2Qs1qYsbNjwEdzNjWoq0Xuzv1uKzNIs3t69TzBY
 g029BYr6YYNo7711xj6oEVbBDeddeGIJHbNlbl0mLEyy+eOzUSZCjPrc+45KFkXAe5h0mgdze
 2Z1WzN5yBszfl/A36qLTDpZgof/FPai2Y3RcGTTAxewfsQJiBRZkPQEI0ZXPjw8lwWbNCvu5g
 XRlqUGaHQK35nlLhSTSQiOmkH8/TjWCYOrQnXi96DRXWAz+Ywm7ekpHcjV0auGgKK2d8zEG7A
 QXeNMasab3hJoqdda2tNgNJpt8kS8is1FxK7Mty7N4fD/WXYnJ1UnyJFyMnBvbJIvM7fvQeiW
 o6Uc6khuyB08jcRBBPgDQLhTQroDL6zhaqibqe7A4B0Ejcap9ImLs2hutRwyMOJnpPmEPICCU
 Udi4RhTSAvbECvxOyQ8efMZ5HBj39jMurnvjRSfHl4fGKbVy6f1RSo1o0ty594A8jcxX5FZ+p
 qPgvN0di8fkkHJ3otoPMs3+2EImhjFAn7l3g6ZLuO0j6dBpYMC+u3gKcu9FFTob0c/AaE9DxU
 urU7c4nL6FXzog0iuXVGqG4l1S0+n9U0triuSw2KEwA64HnmMXIW8A==

Add a detailed explanation how the hardware polling unit in the
Realtek Otto switches works. This simplifies developing future
patches and reviewing them.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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

