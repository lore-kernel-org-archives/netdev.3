Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7AA4F054C;
	Mon, 31 Aug 2026 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186921; cv=none; b=GkoPgwsE7S7+Bf5CW4yFTu/Mry9qRZuvQNAy+MUwfo4DAXV29MkPWu8jwj1StOxD8lcYAkzew70zrDMlZaD/gY2bvFUVIMswmWGdlTAq242LUcB+b8eoK6Xv5CT4GR6wfqmaeLVpwip2cC4XwwLMDw+49jrehcyYTV8RPIJ3uXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186921; c=relaxed/simple;
	bh=oQSA5OGZ5J5HJtojh/2SFw76ml7fp6wvjpW/wbfj1yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyecPqy+TWU7qD5pJhKPb+X6QcKUpZCE5bnO7Eo5jLN0N5BCwFSFP7/6bVZDtBlELU3kzSBjX2yZRIovZLeBw5Sxm9dny6EHiSVSlmg+qTrRv4VN3uYaXXq13RHxFYi7i1BFKNSiYgv+ZjvNkEViYqLKWdiR2oJVdUSb05Xcfhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=UAd5MLjz; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="UAd5MLjz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788186900; x=1788791700;
	i=markus.stockhausen@gmx.de;
	bh=xFMa1sLH999+nXa2S/nmba+dUvHimCGflKkmVux3PJk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UAd5MLjzudIEyhMGI+gbUg8oPlilSVbTJbvnbZaA5I8+et7+oN++Ym5llbvccKbx
	 nT0/YxXCYqp9ed3U8w+evNShbFYam6W4zR1MewZqw7NNQYVCtjl2lza6w87KGZcO0
	 N4R0pPCtpVUoT2q3e5xsJ3GK7uwsjNurDEVs9F1Y2o6wxipYy/XcW4ktNTcixbIVc
	 YCetgSp6MjDUsvWle92Qng4bpZxKe5qabFcn9AdMMnglnjnj0NfFNIIB23Cfuomvq
	 4awwxffGJhHLSY+N6ZyWJ0jlqeC6+Erexf0zmTJR1oAP4BudKK7hQXDwrlBPoKgWI
	 NXAeTurbvfqyBgVJMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b2d-1wxT823RJl-000K7t; Mon, 31
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
Subject: [PATCH net-next v15 11/13] net: mdio: realtek-rtl9300: Add support for RTL838x
Date: Mon, 31 Aug 2026 16:34:37 +0200
Message-ID: <20260831143439.2404484-12-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:kVTVWyeoAGcYl74dx4c0+srVVO1zQ2KKCHkV+Np3dzphsUbkyoV
 J3SotnOyBC5w+ogJCBWRSReDypQKoX0bqnixLctXVqLEMSD4KL3Bw1edXnmylk62uM/MwL1
 q7M4eCskVsAD/xHQgu1eGJ/So2oo2asMgkMb4ZfEsXLy40XkKTlJ6pMQlZhP2Ox+mc2Lf6K
 mnWaCgwA9kFCxHhyAOkQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KYYVq1sI/tE=;1pz13g9YVgMGeN19QMjtqlWBcl8
 sFr2q9gtaVuNJHYD2o+P+x5yAm7zbS3Gji/tYOUH6KsZQIMlWbXQXnLlr6tfQYfs9HU7OOFNP
 98KY08uSLNQo14ThQppDesBL2Nt4SZxQyKuluSKLSfNOQqjTrQdMdgAEnV1QuFMh8BCB1nvH5
 m03oj4P8XH445bl6s2qPDxBye6RqZ1ub/O3d+sAkGMODCyWP3s0yuzfPdmnLSgzdXxBOpAOfg
 xJJAu3ZqVHRQemuovCautxRlEiNJQMLVIVaGhiGSiEAoihHsaofG3T6AlhE3mucdZDL/1CrYd
 GHqmWJyjmF8G/mC+xRf947iD41eJO6JsBXkZskpdMeSVUjcJsXK/TLvL4KGayI6WcoDGigUdT
 XCppY7rHX/tfCDb/Oy02EEcbz2kbYKP9DUIbY9/nWI/dzr8HV0Y94xjboNP9IQ2N1kRJTDPPP
 u/GD2COBUI/75NPnyvBt1MHJAKakUvC2PGzIjCiCrthISEq8Ms7mBdDDXhpJ/EGMMdPG0y8DZ
 Aa2iFoyJatx96k13sweJ3Pfencd9DQihEIJa2nGkcblOAtVTHo0eIIJNXdFpsHTlI+d/xvgpE
 iG+iEfjAq9SUU7nPWcBU84it72leLaLmX+GZtbJnwoPl5aFvJ5U49rzWlQrgPhQod04K7aIcB
 MjVMZ+gpdkFvm4omxlDgaU4NbCliaMzc3fjeHtuUBIXIQ57FJomoYM1/O0Ry8YJN4KDkJQzBw
 l+d1zxp012N1K9UwppDOYdkSTteGFnNy4b8clWCLh5dG2+8TZRLnSdRwzdXHM6L0jPPz3G1be
 aM8pZ4U3A/WziMJoi3pLBhf+aVpRBwxxAh0MKvZtE2f7wkc00YghgqKRcKh8xlaH4JhP5RRyc
 DCwL/d01WLKLoFqcpcBvlS33ax6oIkRqCU6BWHgCH2wE3KbYcdUTQqMUqb0e88qn5xzA07QRL
 0b6TjCtRAwklna0xry258BpipDQT2iwHNkP/1iIWrAsbpDRTC4jGZRumuaIWTVJkzSLxZeToK
 VkWVJa0QU7RmgVM++lPVtmej3R61xOL94KI5tJGBg/1sxCw2oXJxjSU9lCnW3/qsK8+S+2iIE
 fshtW8car5b+CY0ykxllleu2sYPYHOxJUyJol1jBq9gn7A3MEgHSI0F8sIt9Z0VWVoxKS1Vgi
 QFKB/ph9Ov2RObyHBnH7OzMbrMama2keMcQHVY+wKE1LsuRFHMe7UqHrjJ/5tlAJ1CBo950EF
 UIDN2sX7VJmZ8sY35LOFHVtm/+y5djOtA0LmCHN8B5R3q8memOsMwedHRwmocR0JHDWkvI6a1
 Tekxb5dt8a7vsw7IfjHTWTwceIdTsQyUcbJ2d1EWzgD0sYZoY+4ti0zAHGBJmir2Qs86Wz2GG
 iIdnQf4aXirqEBANjEqend3ExqYF+bvSsnsshGO8J83rpfY6Wyh5/Wc/7BViB+Zg5VDoRHtZv
 1R9DSO3bs90KRU4Ir1jHb5m+y8wRNEyxDxWC1K477/hS9flM0S2MUhbjqvEZdvLU5y7vWuzKL
 SrJoasHbRY5A+rWIEiAM2rqMksLVB3Cb930/amcC0OUYdcYa3PHUB41gevpv+lxw/PLfQSh6P
 P/l5kMgLOy9UHGpMKQR/pcjG5Qj4yi3RnLGPw8XbeAe1UxInNaL6Ur00hEfwG6rEujzk1Hs5X
 +PJzqi6E9FIaCEVDb1as2EITDw59KNJ7Jwoudv2GAGpMlfFzGjvtT3qBKPK58mPgEWoZ2XWPC
 1sWxYQ8QU+f9/0fdu/GiLLkC3ycF6YEIZYj3kOXjrRBqISerRWcZnBNpbiSt0yB/na1Mp+52B
 qJ0x4LW/6bjNdEBCqlsSII6C4KrwoKEfa6VKiG2fSlkmfZbRuEvAucbc6NJEsSyRof3hfC5iI
 VYh3Nn3teLc6YYoKHvEV5OgLOT9bBMNvPtIglvmyZopPzQiTWbKCfP3qN9VjHUXq/EHgtGJ57
 uWXYAyvCZw8dcaK+qzComEFO6CZ5dF+J5bTB2cYKMQJzrlb8/go9QO6kTAs31r/nG/jpPuAJo
 dFyR/UZfNtfiEEFlmgSbZthHb7vKkTfvmyYW3bTS8+Sqmc8dKcKmOKS0wzmaS6GPwyRC1kc4Q
 VyK8UeGZQnqziynWmIdK5XRXu/CnJq+eoVdVp/O9ShuCIlPG4XvMyfJ/5SIwRBgFoVzarQtql
 DqX5cFkWiF7FdIx72xUJOvXxoypKKFsIog1Ohynw3i2uy7+TlgaQ3N9ZbMWmPrr9VgE2chHil
 79pZeuHdhm2xp54672XI+abXy+ql0IcyOTuZJCoL8JOJH5kzybMWRcLj3/x3uIxuc8gkdyGyb
 eHM3kADijLzBD3NHe7DHu1KwwSm9b6B46bRr9mmynsBoF/LAF9A/QkSrcQWqCQKIx285U45N7
 LIzho7mAi3iUWzkxgsieZUtcGA5+b3JZJTqaeK1rYUxurxFhZoc2LnYw4pKlmI9rjNgjhntqJ
 cUZNcPXZpa8qPF8DGhu8Q8gX4SuePS9/9BlaNuv60dRQL+ph76v+yfsViITef3qLCo3R9n/4D
 PgY9gNTBLrr0ny8Y679bE7WtwCJUjnPqltJxVJ8VUUfzCooalWjfanthor8GPLs3SIUPpzGoU
 p+yHqtR+ok6b1ZpnrQHN9Go78ilp9cTO3JBKp6r66t+YdFauruRwCxVvOALsCFNIvGlUgqj3e
 byCPSpZMAEXIzt2TokdQWXqJwXh845JrTPJb5NrADMmguGb1kAXQiOtFH4pO62B/MZJgyKf3V
 Va6lRxVDCwnMTRQ9sxHWGLxUspFYWD+suLVLw8hvLpkN6l0bIhN76YLKfVQ8j9hGy5tsbsJoA
 V/1a8QVXrukT+65Cb5V9/nNQhaKKUMh0MwMhVztFzqkSY5881QzlvedJn/0YSdo7VL2tILiLf
 1cLdL6aKa74sGjbJ5pYijgHjrkM5XmmdQVb9NQktxNvAzRSvXMcVRwV4+f7tAtCEoW7gB/u7b
 WFiNdtR3anP3E+/QBMWXxOTgoPOzFYsoXNmCOboxWxTUHnOYAmx1u47YyWsG6oiX4ksOYOqHT
 vqIHs9vPrZgLZ8jiJ4b8TxDsZQouSFsMLlSUJ6HCs6fqLP6TdWd612RhUtszjLfpBejdOyzC+
 6ztJv6CNUfJ5cRkUw7nOXj7VmVcgIqxxhnjQsQIj23LVmHwvnBxMW8Vrim7ALQMONmnEoDgeY
 UfEQny5Lt2LkSdXW3UrCqbK9POL3sXkKbn97gA9pBjwfJEeW2dc82Ak4BQxvdp7QLG6OP6vAz
 hjBJbJ3wYjmcjzX8b/G8lXbEGylMfVfofd0wUEF/iEF0HND7JQfZJF3BOMB3SxMxDSQRK7Nvg
 pepdFswKh+c6f8lOVorpkpxN0JJXVkgubeQJFtLtmQLUmC3W1BxjopoHibZK/sPfyP+bUX2XJ
 uJL8dMjFnsJAt6NQ25Y6C/Gw1AYYIXvp0UOERoIpNtW8AhUOUVkrgvsm3PG8abE84CknaLkrX
 t1GmR0jT0CdHJSV69wv1BBhuOV8Ntp6OX5JFP1w8uYwcyBMvdd5OI6GMhUksiaU2VX2PJB8Li
 O/YmG7tjuTB0bTiDnk0X0TwtStAAxY7gW2+BzBRTs+JD2WKqINbZdMGzhGTF/UhdOt2xuXTct
 4LiNj8nV0zSoSANbneenIYihvBj/3AVMGhyrVBiIQIqv58Gm1g58Up/S6fmsKgPe4xZU5Bmtn
 /ML9vKsSgFjNdcAuDpbb95I/WdsexQT4pFBv3zhoktuYwyS/+EXgBI5qvc8FGbmR7bvF9oXEz
 Vgx5EPLHtGRbaY5mV8uxs1jkepqClWvY70MdeSlZYVL2p5Ktl2/z1xwjCyYJXFIBZq7d5MTED
 QF5pLQ9zdcLIz8J+Ns86nKA0CG9uzqrQHeDxKGRefyBXiCARVblk5WAII7bgT+VOgEo1xhTn8
 IJVHr3NaltkPiNT5Bf9G4Qgvj+amK4FbELB3BpYU35EeIy2rAFmBxsZ33YATR+SQta+jD4PVi
 GRiYet9jrZN10Pg4g6HGNxH5e9wwHkV8yrTEtdOwEZejb03wBFa6UFy1HekgeF1OokgfasjFb
 2p81vpt5txor6/yDHHPo3tdZTTGUDqhYQZe5imOx0V1rLPOSiirnEfzzmIkEIR1b/StF4CrMn
 VHfWs93xS0La0EoYhDSznMleY+7DF+oQroaxQsigh6i8cH/AWzEibdSuAsuOezamzrC9gD/bb
 FiD0OpRqCVFy/pEoRI/bnLWZqEmpZTbu1Wiq+iQJBZQ9v2BCCSFu56q6id2LGzh4zHnY7jREa
 IClpIu9wGo07mAf8l1ua/b/pz1zwsW/dPf+sFMoFv+hNuDai/j3PO/jbnEuNRrTr0yTNTp+C4
 0Ve+Icm5MkVbbzCVCcMUhvEkkTTxtQOtSbKVaQHDK1rIpTMjjDuLN/o72N4/ldrmIdBZAi48U
 hNqNmuhOnppVFs/LSjvKB9ZEIHr8UEHsJSAGNXo21lJ10quHs3X/WqE1ZQNiTrGaWLxWGqulh
 FXkVPllSqsrqThyt3zLGyUTT7KkVR/rF1YkdaCII1ePmIhhv8EDytxkF/qK7WSLuH82V3Y7YZ
 5DlOPrDadJrTDXVyBF3q6TBK0QU0y4lteZ1IMT1HKxgVOVNTSR2vuS+NZTvjW4gvok24YavE0
 eohqh5S47qlMFEY1nQdRbcEXYDpK+1vdap06EwiJh4C28aWNayDvseGWmEJu/mTOsdgbb02KA
 bAJV7hSUmwtbSt8in6JhTO+wqjw0HSibVEQokjO/0mqdA5pwWrFN/pUh8KfgTTZnG8bttQ0J/
 8zzHkbdSFHx28APxZNbV3uq5PvZ9HsNUwqI2A2sBIWq/w8WwOXr7STeKTa4q33eVHh4aCQdCs
 DV3OoQE4atXI3R7o1ovHfBnxx+mTsm6fecC7atoPsjTabuoU4y8UDBX3+9EbXTy6VfyqXLjj4
 ggvg+ldR5dg99y8Kken8bQAiWGAXXVqN/9hkvOVtfdHisy+rR72V704hIFNZoUsD42M3OG2ho
 Ef09ekbyUDhZCYQaS3iudpXlhRGNmzwKQfKOQZiwwHIUIvEJllfVdCledE9bQLDX68OpeIymj
 zOjZjSy8ef3XDlCwCTIAff+6ggFLTLCYpd87Cr19WPIMz6oiBllwS6FUR+k3ujU6QPCLlh2iL
 QevZfS9WcNze4OCcbbpyjcEcXQUVrLQDLxzwQrxvDvnTqaDOXO9BPUusWepsz2VW4SBRXxPxb
 WhSztCrMgc01CtVLAQqfA7rEbEMNtt7K8VCDsnPEmE9eJ6yzykpN+Qm/R+AlRdgtusQLzY2Ts
 3BFkGAFzFlYuVZ6d26bTaVGSdo29OJVcD8+zo2Y8SjeII0jqj41/Oh+OrJ1Nxts00wxX4Tbk4
 OGa3rHvy1v6vnO/mNz+wbONZzW0Buj4YtlpaP1RDG68mtseOhlXEI5a6oKpF0WpbKBRArVYwo
 Tgs7L/R+u0bCrgSU8eW+7vW1YlnsL33DSslstTEZkGRleeS9JbIfFg5mnK8b5iZqPMQ2x/pGC
 tRGqiaojGIte/Tj/kHt/vJ5Oj83efZTFJYK45hx8jbulE7VW+5DZ7VUjGXYs38yu/GM75jthA
 fCbw7LoaNhYqTripPPN0vxUcSUvFZ3fJpobLbLq+9QqofMbgYhBRFkQ0l8fFzsLaFeduDZpBU
 jUxFDpw6jBJ+IQHZXyWbJcoDnnBQgTRS5MgeYZ/jAIOeq+JDihLXdq7zaFCh7D+6ZYlYbMaxF
 28Y0b2YBc/NoNlfbUPwLlCe/r8l7PcWLKlrstEIrU0b4DAt/fMq0mQX7CPvkhZ7UzYghlSIfy
 kSEV0eGLxVJ34G/m27ECzbiSTGRMcbLWDlE1PFDEjhMrZk4e0gbQUY9D03Op+96e0nsq8AdCS
 sYkydQqTcx/drpNpLP9JS3T2M8NEHeIB/miCevODOqIenmzP5TWbxzGEWvuRyLCcf1h/4CEa4
 A9VtMF9hWFIAcjamg1RgIvsGqQRePORmx1xdPGNii+Oj74yPbum+xbP7W9VXxovT2cvEaU22T
 tOawx+e7WtVMRX6+Mzmf9AaQzQk2SfgIRrJbUmodbGmxWYrZU4oaAc7pHQ2uRnM/rcuQDZzNf
 U8mD/qYE4lvVKHG/tQEhSQgRKXto3/AclGm1PVGhlCZ/QXq2o9eq7bNDkJIG+MK0tWElZTT92
 mrZYU9ouCCEFvjJ4iC11k/QelE/MfGwaLP9Vg+Ul8D6dB4pKdAbuxPjXHmper7GBBZVN5uKuv
 +080ya6tGWNOqJk7sfqQ9z2BffryNlLcAAMX1SbTiavYMJ9ZzyT/i09RRyadHShT8BxjHWQN0
 MIl13dQRQ0HGe0yj2qzs2NGK2erYcCdh3FU2uSH72jdGb3c7b46B7Lq84xCBupIsoacUGTTWy
 YnPiJbItcD1nc+KJ0dSWn0jFJcixybatJyfFKvjQppDXfRyVRIg94IlZA8vWjoXT8/VSdZt9y
 hwZEVid878lP+7/KoY1A+otMhBeF6FxEOTw8zadCxovItk8MT4Ev/SjcwIutg+0aTONMZgo4R
 kW5H0WIYvtI3vnHogfDb7yrpfZDdqb+4bGCpUD43rywbPRG4VtVKNwbrYQ8W2dmJVW69sK6+9
 WKfPJVDh30NdL7yVev5h7rWdF5A1XP+m1lnGQFXQZdBM5qmQdKaTLNsCBzNe/3cOg6FbbhVuC
 wldvNXK9Ius2u2hxkyzE/N5zQtt8W3bZmVmdGRF3cj10Ak7zv1o/N8kTPU/aB8Psu0qg9sCun
 DKQgILWqzwBha5Zq9xt3xLTZqgt+lGUsDh0mu5vCcoVYNfLBqCaPFjFPStayQyJF80gk3zvJk
 GtYVL9cB9sBEjLQU6Mbo0As

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL838x (aka maple) series. This is straightforward
but some things are worth mentioning.

- The device has a lot in common with the RTL930x series. It has 28 ports,
  4096 (Realtek) pages and 4 MMIO registers. With this a lot of the
  existing RTL9300 defines could be reused. But to avoid confusion and
  for better readability duplicate the defines with a proper prefix.
- The MDIO engine has no fail bit. Thus the mask is set to zero.
- There is only one SMI bus for 1G PHYs. No bus_map_base register exists.
- The setup_controller() function needs no C45 configuration as polling
  only works in C22 mode
- The PHY access must be activated by a special register flag.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 108 ++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index b90972c1dc6a..57ab89afb9e5 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -126,6 +126,28 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
=20
+#define RTL8380_NUM_BUSES			1
+#define RTL8380_NUM_PAGES			4096
+#define RTL8380_NUM_PORTS			28
+#define RTL8380_SMI_GLB_CTRL			0xa100
+#define   RTL8380_SMI_PHY_PATCH_DONE		BIT(15)
+#define RTL8380_SMI_ACCESS_PHY_CTRL_0		0xa1b8
+#define RTL8380_SMI_ACCESS_PHY_CTRL_1		0xa1bc
+#define   RTL8380_PHY_CTRL_REG_ADDR		GENMASK(24, 20)
+#define   RTL8380_PHY_CTRL_PARK_PAGE		GENMASK(19, 15)
+#define   RTL8380_PHY_CTRL_MAIN_PAGE		GENMASK(14, 3)
+#define   RTL8380_PHY_CTRL_WRITE		BIT(2)
+#define   RTL8380_PHY_CTRL_READ			0
+#define   RTL8380_PHY_CTRL_TYPE_C45		BIT(1)
+#define   RTL8380_PHY_CTRL_TYPE_C22		0
+#define   RTL8380_PHY_CTRL_FAIL			0 /* no fail indicator */
+#define RTL8380_SMI_ACCESS_PHY_CTRL_2		0xa1c0
+#define   RTL8380_PHY_CTRL_INDATA		GENMASK(31, 16)
+#define   RTL8380_PHY_CTRL_DATA			GENMASK(15, 0)
+#define RTL8380_SMI_ACCESS_PHY_CTRL_3		0xa1c4
+#define RTL8380_SMI_POLL_CTRL			0xa17c
+#define RTL8380_SMI_PORT0_5_ADDR_CTRL		0xa1c8
+
 #define RTL9300_NUM_BUSES			4
 #define RTL9300_NUM_PAGES			4096
 #define RTL9300_NUM_PORTS			28
@@ -353,6 +375,60 @@ static int otto_emdio_write_cmd(struct mii_bus *bus, =
u32 cmd,
 	return otto_emdio_run_cmd(bus, cmd | priv->info->cmd_write, cmd_data);
 }
=20
+static int otto_emdio_8380_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8380_PHY_CTRL_TYPE_C22, &cmd_data,
+				   RTL8380_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8380_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, value),
+		.port_mask_low	=3D BIT(port),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C22, &cmd_data);
+}
+
+static int otto_emdio_8380_read_c45(struct mii_bus *bus, int port,
+				    int dev_addr, int regnum, u32 *value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8380_PHY_CTRL_TYPE_C45, &cmd_data,
+				   RTL8380_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8380_write_c45(struct mii_bus *bus, int port,
+				     int dev_addr, int regnum, u16 value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, value),
+		.port_mask_low	=3D BIT(port),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C45, &cmd_data);
+}
+
 static int otto_emdio_9300_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
@@ -586,6 +662,15 @@ static int otto_emdio_setup_topology(struct otto_emdi=
o_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_8380_setup_controller(struct otto_emdio_priv *priv)
+{
+	/*
+	 * PHY_PATCH_DONE enables PHY control via SoC. This is required for PHY =
access, including
+	 * patching and must be set before the PHYs are probed.
+	 */
+	return regmap_set_bits(priv->regmap, RTL8380_SMI_GLB_CTRL, RTL8380_SMI_P=
HY_PATCH_DONE);
+}
+
 static int otto_emdio_9300_setup_controller(struct otto_emdio_priv *priv)
 {
 	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
@@ -873,6 +958,28 @@ static int otto_emdio_probe(struct platform_device *p=
dev)
 	return 0;
 }
=20
+static const struct otto_emdio_info otto_emdio_8380_info =3D {
+	.addr_map_base =3D RTL8380_SMI_PORT0_5_ADDR_CTRL,
+	.cmd_fail =3D RTL8380_PHY_CTRL_FAIL,
+	.cmd_read =3D RTL8380_PHY_CTRL_READ,
+	.cmd_write =3D RTL8380_PHY_CTRL_WRITE,
+	.cmd_regs =3D {
+		.c22_data =3D RTL8380_SMI_ACCESS_PHY_CTRL_1,
+		.c45_data =3D RTL8380_SMI_ACCESS_PHY_CTRL_3,
+		.io_data =3D RTL8380_SMI_ACCESS_PHY_CTRL_2,
+		.port_mask_low =3D RTL8380_SMI_ACCESS_PHY_CTRL_0,
+	},
+	.num_buses =3D RTL8380_NUM_BUSES,
+	.num_pages =3D RTL8380_NUM_PAGES,
+	.num_ports =3D RTL8380_NUM_PORTS,
+	.poll_ctrl =3D RTL8380_SMI_POLL_CTRL,
+	.setup_controller =3D otto_emdio_8380_setup_controller,
+	.read_c22 =3D otto_emdio_8380_read_c22,
+	.read_c45 =3D otto_emdio_8380_read_c45,
+	.write_c22 =3D otto_emdio_8380_write_c22,
+	.write_c45 =3D otto_emdio_8380_write_c45,
+};
+
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.addr_map_base =3D RTL9300_SMI_PORT0_5_ADDR_CTRL,
 	.bus_map_base =3D RTL9300_SMI_PORT0_15_POLLING_SEL,
@@ -923,6 +1030,7 @@ static const struct otto_emdio_info otto_emdio_9310_i=
nfo =3D {
 };
=20
 static const struct of_device_id otto_emdio_ids[] =3D {
+	{ .compatible =3D "realtek,rtl8380-mdio", .data =3D &otto_emdio_8380_inf=
o },
 	{ .compatible =3D "realtek,rtl9301-mdio", .data =3D &otto_emdio_9300_inf=
o },
 	{ .compatible =3D "realtek,rtl9311-mdio", .data =3D &otto_emdio_9310_inf=
o },
 	{}
=2D-=20
2.55.0

