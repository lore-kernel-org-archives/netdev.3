Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E25423A6C;
	Mon, 24 Aug 2026 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578217; cv=none; b=dY+F+6UmCHXXcFoWh+yLmnOlK9WmemyhwzfsvLe7jAU0TDhO/OFl5yTJ5aaBvw2eo4wUYW478dhXghQKr19ZZnM14ZEJlaULBdv23TMQhKSuuQB/8/pa+QZDJ9m+OnZ1gLqf4yhWcQnYTPl4wJGY8HZismtBrk128FCthoWkI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578217; c=relaxed/simple;
	bh=kFCXGMWexeg50I4umbO1mXzQ9dVCiTqWaCoGlUqjMo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hupi/2ce9tbHucBBUbqwxJecMDDxS3YtBPxicO/PtuHLB9eReJCWYKdCo3E++AWenMmMaGZWydaYKbSI84LbaHh5GPCJUgHRRpMEH3Jcuttr1CswhF8gLCWiWK/1QbfCs3eaI18jElbLyAbPqCebBbojYNqcqp9ri2SFgYyyl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=txTwz33p; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="txTwz33p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787578212; x=1788183012; i=markus.elfring@web.de;
	bh=Y0z/XD2V1MR6gKOTyCGACX4mCRcznnVZklBlElv17M0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=txTwz33pKPmNUbbv3zafSdThUO3z4DaSDpIIhP5H9IFnuJLodIEUMfJwktT5oC6S
	 akZPzkPo69/Vf9bmin0+qhNhqybMR0livh+c2ucxALWKV29uDvwkLGmYunOLa0UqS
	 vD2LY96GOzfD34Q3hnhQMThwEGJOf4DLsYrdaMjdSvbMqs551+1tnte+AEi0d4LsR
	 5BkH3LtUcuYzsCyjXdKp4jyjUT4y6dpEWi0wb8BUm+yD05wqOgLo0LDJ7gRPJdFJU
	 18cqQPmRSlJ/3s9w/M9yD/7ySmhbKbzOUfJbRY0sx5m0p6XEWy+e1idT+r6kSD/fe
	 MZxx6PWl44O4LgXQKg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M28WT-1wwZsQ3fhJ-00GfeW; Mon, 24
 Aug 2026 15:30:11 +0200
Message-ID: <8b845671-c9c9-4a49-b54d-5eea775369fc@web.de>
Date: Mon, 24 Aug 2026 15:30:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net: ethernet: renesas: rswitch: fix device_node
 refcount leak in rswitch_get_port_node()
To: Andrew Lunn <andrew@lunn.ch>, Manush Prajwal
 <manushprajwal555@gmail.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Michael Dege <michael.dege@renesas.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <6a882352.ee10049a.267d65.7a31@mx.google.com>
 <92de3894-3511-4f13-950f-60b3f6911504@web.de>
 <d76baca3-4ccc-469f-82e2-477f3aefad4f@lunn.ch>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d76baca3-4ccc-469f-82e2-477f3aefad4f@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kEXByHeMX30xoKEnqffqGEa8rNGTK4uzDdl4tfGwNJ5l+Cfcsgv
 CgtRT8RhBj3qhMxU8vcfom23xW7GG1usZCyvRTs/r76XbF9ZNRGJ70MV3aNdJF8lDarYWWz
 i4NTibAxdVeH6e+8Qa7gorooYg5j+te5jUJbjlnHJctaiIiucK9MUvH4F/uUnamisiJ//Zq
 C/zEtZKNlZjJMu+yD0xmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d525oSzMsi8=;yjvjhRezy64RJOJvrWYAjRKomrf
 HhvbKzC88qv1H1fGSudzWYIoLClqYMY5hg54GSOagSZaqlB+BQr1IW89tMwFiEthA0A2fjvss
 5oV76dbuwFbl58ACFyd5rZGCHF1Q/v6hffm/eAeWMixxvCdprlqE15iqBeZnqIv84P1h7OeIM
 80+mF/WxMFl6Ox7HwThnb42cqZgl2mWmZnSOBjWNxQjz3bYCoMbYJ2Sq00Mgk9B4zuwqnsxpw
 4sl2yoRpvbGf10pH46tL/kTgRsyT7pNu2v2NsELT9CDQFsXReLUnX8StkP1Oww/0E4Yd4h8r7
 sPk3LobpAw+GcgdUL1OuuXHBqHQtWbPESS4HHw3GUCJz7KWJ73CGv2lNowXCb+QcQQftzCk1k
 d0UYZfugF54JJidKEjFK4gEg+F2pHCZ5SBddV27jkf8xDYH0cbZty8jb9Gvj8CzkJbrA4kaIG
 7BKBphYMKyDT5cBTJaMI7T2c2MGKcIH0F12zF+9xY03xhCbFaHDNRcgdIFeZbA3hRQzpCbKKw
 sJty8MreQxNJIYxUTnqD2gQAhJLHc414WPU6wKGEyFT692ewA3SIELSkugSUe8Vs9E8JaHRw4
 U1RrhT/FS6O75CPDh/L3RQ6gmcgdiIrsBg58SnlNqLljN1M4HDhCS78Uvn4nK920SH7J0DJ9D
 FgQIs0CLadGB/HIHOUpp7YX17p+cvgBK+1CCoyNBg8uk9GSzqniwSnkNbjXkmCM8LwYxi6dOD
 SXYRfT4M2Y0m7DYWzCzitJ3XwGUz3r8zkxnsMJzS3m46EtcgjWN7kEnmn7gpCi5677/SZ8wP3
 jJ8iiSL4v4JqmEj2pJRYqIXwy4eTWoGe/C/ivvUGSOhsgzm1NvnyFBE90XnLTc4ZFkHH5p0LW
 hvq5TdwBx+ASf7s9LVde9PjZ5Q3KHMJJZfMgitbQJAYRkFqcBTGL2QBrwqFuyA5ysbdYDKddP
 bR4+WIAge1xRSeOtomvPT/NcKS7mv3gfNati0WLpeGgRXKzDthePA5NSBEQg1QQaLBCsj+QWH
 8trun+TG4D+dcQAFwC/pxglWywGP+Ms33Xpja18aBSVo9AYJxY+F+cJ+ssJqogrVHnvSXEyR+
 iO257w3Mo5xfA3WnojJuinTzXyHnbOGVYsOAHO8H4jgs7/kxS6ZyY5NUSdE6w+CUxRhW1kk+R
 DLIvdWHMDuwS1HrnJjxGlxhhZ4goDntFLt6hTR7mTXwtKQE8thPjx5JhpPmpdXikDwvuvHzXm
 jBzCzcL/5tTXMSW2yW8qJ/yAG6I3o4mXDmbgO5jOqXDnusr3FwI7KVLB0SfB0GcUJ8ItfIXGr
 UiMBmG0Kj9mGZRWYSoMn5AqQ2qJNAoTkKyNYs6VXD3KiutJDDmewwvc3ABh7CoINfE4WB8u+B
 8HfU1k9BCEPD32H5uB96A1Wuc3RV4CRHMuRl7yC+GRAn1iDlogZCcuvR290pud6z3pvPrThJe
 zFd5j+9fz9/dIdmAdaMoCGLfo9ciSijPWYO4II/uEX7A645pihd2QTYBewa3hwB+o4xT/dpVA
 1sosps9uTDXza4m5hksKnK7XnUoU1cmdeKBEdZUcNCHTAJiTn7MCm3fjbJLy8R22j+FlypgXV
 gUbZ1zIfWlXt+79V0At2jLqUCgqDXAFoPgz4y+n0MBHAbdvyep5bX6hFo2v582GTULfV0Tiib
 5Zuj2PT1rrzOuURCVeoRh+uQc3iSfXcS9c2lLXntzZ2H0CfiVJsV+GnZVLMl82azyPumBzesn
 l1VUXOdnrDDxFCvcUES/oFmCiXrGKWhP4r71lkIJvoaYIlMxcG9s8uFiRFKXchvp6hs1QOSHO
 gf36mnYwhWgCNmXAY/XuSASUxQPGHMxhbtRdMvSoXkOU/2S+wyzzjMM3RClqpcgkO8kc0QVEF
 oQvQJjJyFcUgzt69Onj991af0r8Q+Ej3L2AiMoKESV71Nym+m1eciqcPtDX/BUJpKG77/bfVT
 M5y22zEFNjLM5ZlnNDQnztypyC6Qmwk3NpOI0j5a1t8OLlUSvMBUhwsWKnigjH9Afnw9aByxW
 DPYybVx/E8TMMDd074VtdnFI9UvPPIsdSV8JXNCXNggtiZdspe2e6ydD1VuaCDUx+PINbF6oB
 MfB6xJM6fYZwp9YUJCdJygtNyj0pkEoAvqA1bjZ+yAlYdSznZ5Plat2IU+0XiKiBDB/wPVkIg
 SrXlW5TxVkPAOUtDAYYrEMkWZa68jSQt5z0diG2w9sn44HSYlvFr0BbTMjUNcKiprJTICzLAS
 0oCPd7xGknTKI4xNUGHt1F0BUrv0AvBZCwVN858E3WZu5WUwTWujJEU7aiGyODSvZdGC6lLOI
 K7ZUo3oTYY42b5P0Stit0N5YmIzEmx49rSaH+tDnFrmuc5AI5/2eM8SVEipTYW8rytUu+VXVu
 9SFyvTIRUUsF9F6VORrlZtWF+na5wMU8dFFovXXEK6JE6gc+t1UPv2EtpGtm2gol0BohlPfDq
 jkmr5WlcyEp6wzD15nV3/YYdnymKxkPFrc1XJBuk0t4fQ1/sDzzZyiQC5ClmfbYkjBhHoJ6Ue
 FImFFZYNHEzFq32dLSOERP1FGlrnyZiDhX1DOeNrMhXcjTP4yA37UMxEhCxoaplT8nroLnjt9
 zIQIZ/qqth45BPca1HiLkiV4tGuBvAeBMRXVON/NeH6226Afsu8648SRrcMRRr8R0w53kKNoP
 dPQvqyhWTJZ3sT8D8XtICFfV7QTPLpTWoXofOJZxRbk0pei0NX1tiAkQC5AUiBRHMDvGpX9gP
 OBbsWEfojzNvIJzVXMTAp+t8Ju+tIg4AxcSuDAFjeebfHF0Sj0IAq3/V2NLg43uZGko0ZcCWM
 Y9jYdDptch8siY23M4Lp/kBYQCVqjCmbr/y5VnWZ1KNIwTe+NjYUPVaEozxBZ4wdsDCHjBBPh
 nOCSD066xHygvlVRU+0j/tt1lSa1iN5z7P/WVlMawQbBSBmOXS7EAVmBu3ivQ/aZmYEfngt7A
 iwW8uilnnqFphehlsTBv1wgIo/XJK0F544/aJBg2Iulby62dXwycIIuto4t7T2XFX79u5QCc/
 s6iuyTwVRiWIxIowpbXfBsLy33e8e6d3JUWyGPaVolWC2cL5LU4JoMixWVrEwdbpl9PTT9Fz8
 HcsWVO1iUt8fKZF4g1K6PYdKfBhJDHCpP8CO6KS3kDDOFrR/cgP+gcN++vy2MhBcDVvodIzqj
 jQSAAEE37jxGbu3Q76FGidT1u2PMJI5cUryS92JQzHiirX/HRaOfv4/bd7FhHPUB8Abkz00mX
 fP6gxk91yIBsoe8tE4AxdYLD+uwpqehqRERjLz8UOjNrQmdFWGt6GlwzAG+Zjd5AAHO5SdCBy
 QAQIJnYxT9kLcu1+fX9OGzM1mMSk+EDFUHqbrNKXsQGqnoNc79cYEDXFyR4h3xXi9DRjejRPf
 JfZG2ZW2RPxC9PTLBNO9L/jdDaBDeMkI7+vqs/9DlrJtusBextWmcNIhS3jlgUPTFYHvLRdYQ
 UTafON/Zkfwn8xnZh6BMsO+/fh3GFMjeDyKItJj6VeKr+yup9R7hUzCUFg2VJIo6gunl4Nt6w
 MeOo6ZiG3pi8MoGxVQvlIgVBTZrCdnOW6F7dFN13xXgCVVU4oTpox1Mp/aDXKINaPxLUr0hSh
 vCIZvCdAMAAfocK0gFTo/OX+o1kaK4LdKZRI2Vg4dSHVEDYTx7MP+6wc/Si6a/9ABQB9ZMlaP
 tn0Vw4e/57rQhcF0qU1aHVv5ZPGTRU/Sp6EmrX7rF3tFwQI/qBQQuxnzI0k536o0jWeTjIW2u
 KKRWu+M0mCePAMJV7DJAx4c1XLyjhRImUDBK1kJ04dv7ZJFdqQIx4hjKYVcdoKblxit1iIJRP
 5YRn/btqtzUIqyb9UP20v4yxyHxcpHeB/xZ0tCYoaNYDO6s6mVCobrw3b1bhje8IHdr0lo8Si
 OeaUuSdXuVDc6AHJlzBVkiXMRyLnb+/zCO60csY6vDiiU79l6mMKVolEQnG7P2zzxqSCGR5xz
 gjwN1QjEpwkW6nVtIq8Yq2SVPz0XEXzHJbd+atJY2kav34AldnZJi/JjDp+ZxxwVe+1w/ApE7
 tnfll77HE6r7pHgZUw+HEVXMbAxrdhJTwKR9oyoX0m9yx8o1B5fKuRHwcAF7T6C/xjgzNHZMu
 Jwvv01iy0rYlLvMr7jHlMvAUO4Y/Le8BpUwHt+84i4G0q/DLJcwJQkLRaHiiERMTAAlBhbgjT
 a8o+JY7T/8cNSy90ZwwiICv203d/Kr+FQia7z80LWcq2wsSx32ckoyff+jiCr6qq7nFA6pTWx
 ooczAWAT22pG4WCOaF/+XXYM65E3lfnBhoruPDCPf2nhy3k8WSY+8fykQpkSrZJdosdkfaXX7
 kqEST2YBHkI7JN8xfbbHol4XVUMFyhOqiUrICMdK+sPzJebsTMlnM803E0Jk4xLcU3d/9KvRy
 PU9MRo1zIDr6KLLPGGHhcihanLPxy2Mjq7N6OGtON6wqO2CM2MyQUb/nq6NHkS+NwnAVnsrar
 aFqL5+MPNWVlxvXYyL7D0F7LI1HcSYJSqUhntfoOtE/L/8ePxg3lnfbHNaIK8q+f66/9LrnVh
 vk0qsYGi16iu5pAEil0xLDs+OWnMkCGWuratEn8I0vZnyYqqg6rsD9iMjb5RU3GfUKOckyTUN
 vV5j4QYb3EI9WSHA5jDb8MtvJx4q5DSRhDNT0tjenPgUkfoZLA233j0BUYAnAL5PH9WV6Cxwn
 2jZWXol9fzQ7KMGgFNk3Ud1gfnwmAf3GAb0b9t5rBgDVCojSTHPSY100Uzx1pJB8fpklMBCf9
 xiaj+dUI3fcxzc4rjR5oUjhwqa88pmXOcwN8PIts7dVLqQ56tdkQLXhpIMNun1fHi1jQfZWk/
 kFZx5wqFYDKpL5pqu7+x74+nlPxP42mani+pu4q8Oab4GtYLqYEK+WciiYGWisdHV51iwJeLZ
 VCkpOSSVpuK/pLuwGahnRKwkHrKCfE9ZspaJfPs50RgCVBMWggXSZUQicHjegJBbgPCH54jsK
 OvhnKa8Tr6DBuFoyjf0wF2AEYJSpn7OUPD9pl0O2dz4axuuKEqpJNqBPpr2pnCGnoTpzhwNtf
 ru46MCTwTbRYnZQJmeB8OzGehezZEplUTa5I5hI2Ja2gceJliKoNIbIsgaMB/orFooMDM5DAy
 zbeIcG4HAqM/1A6LYbDJ1DuUyLqaEOMDu2eVufTGXQ41nyq9NR+8/Crqdipm6+jCzE4o2UJuI
 0ndx0Xrq4vYK/YwLxWDc24s5/GGuX1i/O8A7HbESgdeiPROBySYPtW0w0mknGUO4g02fbzPsR
 HFrmADjE7U+jCb8/u6549r/QtteQ4a28z+HB6YmBlvEACZ3SJ5ymotNwl1+xWlmDsSITHljAV
 urLwz08SzuApMTFS7IQnZ772WuoNX5QoLNbvsbDXrETajtJeOid8wWFgJ9zhrMzG8SqWq8SNl
 OpbIOpOuKre09aoFr5kdW/7rRVo33jWZXtZtX+gPgNwOgwpFtq6Wcrz0zuv2acTKs8e3+Z01S
 VLsL9Y078xK56+rCS+x7sM2kWY8ursCjgVKEVtXpt2lR4V4sSHsOpEYfVVjAa6tnSrZiquxe4
 5NNaoFn/xhnATyPYr63lpwa8fJ0jAzVsVIVD4WqZ0iixkcQsA6wU2SpWtktUhlf/H5zlc5XLs
 s/SnlBaA9kU984uR7n9sEHMI2dpfrEydgspQoGVDOYDBGllXBTnMQ6Pb6cfyCz6694VORoWLl
 Mez/jfnVT5mmlXvBA4pBxvppP2+PsfSk0R87AO/x721PR72puWpouwl5TgANytAHVBFIWciu8
 btPtY8qUZZkx8EbDsaj5xky1ThP59ikWSxWjXvdxJwaGXJo9Qt0sx3L/gqzeokJdHcHKqmHkv
 1PBXSNv8yMf54DsKrftxpwcVlDT3zGR1lfd2ZxgZsetNV4LQnGYwATZ1y1G4hjl6k3a6EdXvR
 ZVFDWWUJonWp1q7ZyZOP6UMljlgNxQVIkOQd5HzX8/r7kDXA+nslsq/yy7vWIP+mkk2CJYU7h
 LHjThVtaKYer0inhrtiV7xg1/tYiu0phsANo1DQc1SfqqDKQmELcUz/rjMNUMCxhDYuyd/mXt
 sI5sB22v5rdgSevdI4DzHmAMcdt3jmgHuOIfAQQb+Xr47ddDlKSuR+F+yh86rxhpsDgm3iKxR
 UWQYsHHD51e1PcpvmpHfK4BOGJs8wCcEFi8UhGY4ZDOCo4EwtoXxfwwyumRHIy1RhaNnBqWZD
 rZ+pm3RKyJSCikuXg93KB4IcFB9h9htc5Jy4/wK0UyUae8ccCBVYZ0PRQ6g8UzOtz5n0pAPO4
 /v2Ige1Bv3N5dOHfmEu7w3a0z8I9UuCf5jC1EL+H4rnluWiw7RoxYE21/ddiKrARUYFeGSlFQ
 se+wkuMq2xAqZjfhluwO8SAkCNASLjyRpM83qyEGwuyCL6eNg8EiXVHPgNaHLq45dEXGhqY1p
 n9ZGb2odt9aKzAzrVf3MlNWDbt7HRGPTl7j4Apgmt6AZUFeaJGw1WUQErBTctzIu37uNcbmK2
 Fm/teew2EIzvecHOsP0bWjblcd4j86+i/K2frFKSdZRE3yQNunzWE92VHL34DtEqRRMDUksUU
 /WqfbqKUpvrs4Zt4diYzch5brEEdItwMvYRbucMJuDR9G8emEhzZYHyX7PSOhIMK907mLvZs8
 g4HZRZzACFKWhSiT/qWsKKaRrmKWCRMG+MA3EvSp1JCShpvzaGIJKsRbbn/lTGarMVjusErNs
 DwVtqcyJSgmRW81MJDhgMRkhHdKS6E4hqwBB5loPVuuFjHGaxCsd7Qx9fHWZ7zSFmp/LrSL7x
 g8=

>> How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D an=
d =E2=80=9CCc=E2=80=9D) accordingly?
>>
>> See also:
>> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/process/submitting-patches.rst?h=3Dv7.2#n145
>> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/process/stable-kernel-rules.rst?h=3Dv7.2#n34
=E2=80=A6
> The stable rules include the statement, the bug being fixed must
> bother somebody.

There are failure possibilities involved.


>                  Do you know of somebody bothered by the reference leak?
My personal knowledge is probably too limited for this issue so far.

Regards,
Markus
