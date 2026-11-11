Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794433789;
	b=i+V7pnYpIP6AFwEYvI7SCw9MWsS13SOHpy6yfVq2dFZDlu+JntrjsOg2W0/PKgiT9P1X
	 K5um3hP1pSM9+VaaxE4jjz+lzT3ovrOGpHSDyoKy2Kq9QbU15af6Wm1AT/Ne/UgKIIOu5
	 TadkRHaWjWwMVf+7lH5CGXXM1i3+5QDHqMbbc6UilYmuArKeZNIBKX1XGpclHOcbARVYG
	 vDn0LoHKrlWmFTQQO3LCo8Iw59VGHyYIx6oZX4cgy7AsydUW75hNY6bdNstulCQbrkyQo
	 4QdPXOTcaTRxPF4JCgeVfmH1EFNpKwWI+5/eI/z7SlaeqWhrW0j4oZyTkxeDjQ+UhfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433789;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=5hjKfboVBJ7OBGDq8Y9w5OdAYwdgZTN1RE/HZ7spSHE=;
	b=b7s3rkz8nV87CDxZ05VElkfR9t+qUqhcQgh+qftfDbOu493OsM2meNC4+XDpVlQoDUHt
	 547nQ5egRbEeASnMRYsGXHCo12w02sDVF5pjodnPi3aaGs2hsHBhUPcpLKV1eHOYJLx2Q
	 VQMzv/dMDcJQRNFsf6xokRgtJicpZc9DsoP98R9BqmPOZzAt+nUwLin9RbYFctIwTNnvJ
	 NEXkVLVAjG//rHhD43z0qG2dgHuDSgKQgVQ/WfQQajVrn0CS6Qm65FW6MI2nTGfnFTvg7
	 KczZXW594cReQm+EAf5L+xFnkDNPPmUymbijnC/zIHPes3QGX8hObYGFB/Yq3dl6o2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=GeyeUFFi;
	arc=fail smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CCB606A32A
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 21:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6CCB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=GeyeUFFi
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABKjt5P1427208
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 13:49:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=5hjKfboVBJ7
	OBGDq8Y9w5OdAYwdgZTN1RE/HZ7spSHE=; b=GeyeUFFiqCEKPkYZuQ6WCtcJ+ir
	veBlhkSCp2XR6ZvVC1Xnkgk73qpCo4mRZiSx00pz0ZaPhEttkWlhUPmxfs40TTQ5
	/X8zBYWeMo5qo2ppLp4+UZMJyHFMoiEX2DHlDDezkJ+ymYQXutBVAG3oQhntG9hM
	ZVeerH9U4yDTyfZo8k5T3RGORiWlI7Sy4seS228sgPILhH6xhQjGBjjWZwg6qsn8
	Vlh4ScYyoi1E4wMGavc4pJXl7aCS2fuFIr3busZsxl7CXn30LOVds332fP4+nkTl
	nDWVNpN6J2Xxb3bHvFuoJ6S2atc4WxsC5TivihwZ04AgSP+XyPVs1XTkmTQ==
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4huqrq122y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 13:49:47 -0800 (PST)
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4ae2756fa7aso26690355e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 13:49:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794433786; cv=none;
        d=google.com; s=arc-20260327;
        b=kBbsaryctiPv37OkV3h9O4DJgMmbNUhXY/2vLjf9M3j7FZktuKe9CNL29FU/tsvWN3
         z3oNt40xegAiNE03k9rkl5fJhX2OQHJwcRwwEsFY47e9p+d6LUAk9RnCcDWXFWUWX/Af
         Vtk0cvam7Mf1CKieE9zCGkBMmf9PFyVV5hhXuCNp4bC70C5+EqU4gabnmmJ/55c4orQ+
         IGR2cJ3p6erSrQLe9ik7RPbTOTGo6z+2uFGB/7ExKWFpeFk498peZULI8CrLrhOlM5hg
         j6kK0xBlrnj2e3FmknQpOOSKaKbk+6Te+I8JppPxRhBSJyw+FxmHvTZIgEFH5yDG4DvX
         LXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=5hjKfboVBJ7OBGDq8Y9w5OdAYwdgZTN1RE/HZ7spSHE=;
        fh=Pmj0flJu1UnzQXPteF+BeXRUrdGICr8j0xYNarx7zbU=;
        b=df30JNQT3KpnPu9kc358SPLBK2QFyLVWbCXJS2yfaU0p5Pq9o3kW0aE+IAXfwurKDc
         5b3A3F2IBC0bC9cHFzrnbNLNppi15dKVcohPoQrF2whiOYi7sbQHYdtT6xQzQClvk1HX
         B/ypT5nAo5atkLUfmrxPbdOzqUPrDEyFDYU2YQFtmdgjy3RpuVTNjaKLN8AMId6C+5gE
         QyhrtQVtcmdVGUOamE5z9sF3Ghe6YXXlRHJ2UkioH6bnW07Biq8cW/VZ+dn+QoOEDPnE
         oxbACyPGlNFeWiFntZrx4EeCvkTqXT3l+eK82hzZFNbbOXpy4h1jBosN3MJjzTl2ndib
         d42A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794433786; x=1795038586;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5hjKfboVBJ7OBGDq8Y9w5OdAYwdgZTN1RE/HZ7spSHE=;
        b=0FLqkTWUMMnmJ7JI7IMXp3EGTujeIuPa+5OiOH1ysGJ4Qa7Kzf9pbtyn84dWuvHHsw
         axGc+Ox9b0DLS4PgCLW5kzIEcp/R1lIQgwGP1QxHf+K4S0yaHZ7yQoIG/SJTc83wz9+F
         /Y+3v26Yoz0AP5wE5tgsReYaAspgGJQindcKItnfLCBUc+HIytiRSFiYyLou40KNfxpo
         NmVTwB19jICZ1RNK/fq/1OIvij1RH8T1k0+Kj0wkX7UXHWtpybJUKzcIuxK9jhOBPnep
         aDjTz3rQX0klBkRAIiN0wPVF4sC2d8PIISTBc6B82lXuNYuyqKyZ0PkfiFMPghYUm0bI
         PReQ==
X-Gm-Message-State: APuU4Z/7bLX76CXyfjt799Dw7BetyaBDCpP0cyfnUA1aMStBWVAkvvqZ
	ntP/OjmGykw+d3lYtLXNHlNLuh4aXBHzsss/KS5nieHly34HTvcrFDQli8HmnyC8wKfexSqLZGF
	SATsCgABsdGuD8SeowS6hkKwf/rmw3CubYjeFQ1MAjIbfA+rtOB61lWAsLtVigVwRRec5Qq+2Xs
	iG/4pBCn1R3xOfmx1SnuPUzYWAfqiNZgcvA2RZcDbDfA==
X-Gm-Gg: AYBFou0j4LDMaGKjIWhTeiwUzOdrdlyxOqICxo7d63sVMI4M4XzL3tHYj7iZ4v69+BW
	/doeVxsSWArU9JKZr2q+W2PXGWLZYFYA3OQGlYiXP96OguV8mIa+5ozXHjHf+A4eRe6rfgCoIQv
	vguic3+I/YN8IQvqIWQsdjrwgD/33EQUEMvu4bGUVK/NkNBLzap4RvPWCUic9MmyfzuTEKpz73/
	NRbEyN8Vcy5nGJ2gND7n3FEMZXbK1Pf
X-Received: by 2002:a05:600c:34c7:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4ba093583eemr60183795e9.9.1794433786502;
        Wed, 11 Nov 2026 13:49:46 -0800 (PST)
X-Received: by 2002:a05:600c:34c7:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4ba093583eemr60183425e9.9.1794433786168; Wed, 11 Nov 2026
 13:49:46 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-1-toddfreed@meta.com> <20261111005533.6436-5-toddfreed@meta.com>
 <DMSJB8MZZCXK.MCEBRZQDAM5Q@gmail.com> <CADh2yMx8MPjcH7Bpj72rNNd_tT=6uSC5Ow9JyGjTMjFgs499Pw@mail.gmail.com>
 <DMSM3RNRY412.1GXB07F4KGJYR@gmail.com>
In-Reply-To: <DMSM3RNRY412.1GXB07F4KGJYR@gmail.com>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Wed, 11 Nov 2026 13:49:33 -0800
X-Gm-Features: AclHuK_3wPHrs7nAKCIlAv8DB3IRwLLgS4civoUiRATHWDoZevdks1911kjhq28
Message-ID: <CADh2yMwFu5Gyadm2Y-NHCBtayEvN5H9LUM=Kf-tT69vmjm0DEw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 04/15] psp: add support for socket-less psp associations
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Donald Hunter <donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        John Fastabend <john.fastabend@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
        Wei Wang <weiwan@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=PapqFShd c=1 sm=1 tr=0 ts=6af4e2fb cx=c_pps
 a=IwH782EDBk/vqbJ9rM8UFw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VU9VbmEmTQsFja8ue1gA:9 a=QEXdDO2ut3YA:10 a=Ng9YvVcppn9CIdWre3nD:22
X-Proofpoint-GUID: gBuS0PPjJDz4NjFsOSTc1w7ROTgB-CVo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA4NiBTYWx0ZWRfXyF0fW4BpQ1YX
 cpGdqyxKkFQtNqw6UO6He8Jp4Z02JNGIsWhHAnpGU9NSsUKlNZVmXm9K/BOdDJIWIA21xfRU++K
 2O7qIgtyLzHkE2fhQfGGwWPCfwj69f4=
X-Proofpoint-ORIG-GUID: gBuS0PPjJDz4NjFsOSTc1w7ROTgB-CVo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA4NiBTYWx0ZWRfX5Fa3/0G3Ghkk
 ro4VTfPZfk3k7ZLvHLxo35RKYIGdBCGurk/KWDpZIHS8s4gfOclMEBrRqBhlgH8rxRUMena7Ggm
 bdPFlfPaOmZyf+SYY4uLvidMlprCIIqtezNAETdNvcFBcGbY/HP/Pt3h4h+cDk7AIw00j9XLv/F
 FwfvAZoFqDJz8vmDNb2jXq4P+xbWvJhuwZV2PqrudjPXDJ0EhjaumelgV/nqosZUC+BqbrO215i
 udDBlcIofl5KABXQcMgym/q90lYBD/lIiZVY08ZS+PKONmeC8s1lzAcjq4RaIbZxJT4c9ZXApej
 75W+RMHKcHBiihInfHN/fq0ZWx+TCIgLjY2Rr84DIsnwPW2wywUEQZCyv0yLi9bexNzY9dCgBSC
 Kuve9tZktiAkKEQDiMQh7n3//TgV0NZMKVvMD3WR69wVAvb4nUEInWnEW52aJggV8Q1AB7Vg51a
 7yIER79UoDkAWhAeM5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01

> I think it makes more sense for userspace to just get rid of the rules
> before rotating the keys.

Ok. I will drop the rx assoc objects. The robust userspace protocol will
be some combination of using cookies for state recovery from a rule
dump, and using chains to flush old-generation rules at once.

-Todd
