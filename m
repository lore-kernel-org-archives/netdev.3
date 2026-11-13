Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582669;
	b=hewXxa479ZAPLSISgYaMp06oG6YTfQ7y/Xn9hy0+jk4rx2pM1AonsC9Ys/HAdK68c8ke
	 DPBfwKuBMoWFla2sTIP/FroK7IjhfHKWDWlc1lEfrHYtvBBLDhsJahz3Nn1vjx17vAwZT
	 PWAcB3rZw3EmOYIx83lDxcfLC81sTqD/DiSsPkMWxPkPjlXKtxojRvooeTNpFCgteNs11
	 R9fMF23pAe28GLVYJMDNb/HOuLBnL8VaFzTL42lFt8bO5mmzmDJ6PM90zfbU4+Od6CmD6
	 jQzwBm/1/KVIIFA56gvOFI6LcJMB+KU9Ps0vxuJJC8eMD81wVJDYpLPClnFXRemnzaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=5EK390bX4i2o2IL2ohT6EbD1TseMnU2HMT4DgAdMKdU=;
	b=NtdPGv07rvd/9dEyXaQwvT2DRzl5b1eZIFeU/IskOig+DZ8Yx60c8+YEYbNsmCkh8/RO
	 tuDhDyaiLrZAY9gNaroN6yE4kZWzTXsa7DD/Izt4+FGGAMLx/kdrD5npMkbXmkzrE4n/W
	 QXcJgWbCkJg+g1N53Zg8AJKz77RwIfzhYiaYVXyql9qdqgywzcK/mawXstQCLpVKMvudq
	 0QVWlC2LmIMO3AshtOg/RbgWl5dQTrE4bTxSnQzUe/4YDGhFDA0ZTUw1zos8Jn1E6xIIf
	 VanJoNMl+j1CUqK3Z/+YOG9ie+XcxJfTaWKG0uET6xcd26bzDIAgVNJpiHGM7PKvEtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b="Oz4jv/Aj";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA53606A331
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CA53606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=Oz4jv/Aj
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a7a3b29c11so1546855e9.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1794582668; x=1795187468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5EK390bX4i2o2IL2ohT6EbD1TseMnU2HMT4DgAdMKdU=;
        b=Oz4jv/Ajueh5dt7S8MNTbmUbzizV81pAVlsmlQLBQWFGNJP/avGaIhwIKkkLlL28fM
         u0v4FnMZYPjrWKkwdbA/xfWapJ4ARkAc99qHoCVB2vxtAFP8Kh2UMV5gohyv/YQXyCyQ
         mQCBBx5xN+i8iMTrbTIqUfmrQDUE9WtbVu5Tnd23SC6oIHb8b9iIlZC0oFHloklF4FTm
         oFLX1iOQWrtUf1GAhepJC12tPDNFrAyTf/fPsytLKkT3sEKqrcA9zCY49FVcByRJJe5q
         nwBXvslQjCgbijhxJ35l1MgXXMNPXB5ZiG24XVAL8uXzreoEmYeFdNV99YJd+2NjQp9I
         DLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582668; x=1795187468;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5EK390bX4i2o2IL2ohT6EbD1TseMnU2HMT4DgAdMKdU=;
        b=eXONN7BAKS7eeSgytxkzd/dvYAtuvLfyqczhDT2iYa8mklpF+ZpjFz6Nf1Co2908tk
         4fbghgYJGf1ACwOjXxxQHDLd8g7GsNm8qMyWcF8Asd5ImWGdmASNOxOuCSzau/r6aVRG
         CsPY7BZGNxzAczVZte0WZBjjGuiA5/CDiEJD77mj5Tz58jaqJVUaFeiZSiensGPJnyYW
         6H3hlz1VXAH99arnlkps4bfrF0ov+/ZUdyd3ItGf0XpR/9CkIjvJ/5fmNa05SWIxlh6c
         J/RKYlUit3QeKxHLai9UhedTj5p6LcVlsz6vRS5GpBm426T8vFmwNKE5lt8zegbzDSsD
         3MDw==
X-Forwarded-Encrypted: i=1; AL+hErHu1jL714P8BODIv46amYVPcH2iBWT/FgpoAxi6xBCUwrojA7PbMux341/QiGaJeRKPyJMB74Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6SDxH1q9m87KI7wf6BKAsOrKuQG0j3IA8uU+11kyRhYG0PGkj
	LUEbg7gQ3P8dLsvfc9Rc8UlKFZGVMA8utlb0Me4b5WwUg683BcwZMi0FqGDHwI6N0AU=
X-Gm-Gg: AYBFou0yu+WtmRAITofXTWgAZUQVYlAAIIZXz6TNczyt2C4nTG1ZiECu5pX8spe5gFv
	G5FWtRU0WR55mhTrJ2F3neoNntulKKw9loy0DZk6RL/Y8eRHiWUH+1iVYLqQCL8AMA+PLPpW4z6
	Qe2ZZArxiIDrAhIgXN+Tm4vYrQgP/n3n4yckQ2dGar4N7EYHRQ/PY00KviPzJStafHBDi30J4Wy
	jcW2DsYq+HyDXD97vvg9wPntw/vEZhrg5GPJ9UkhrELyuPYMYCbQQsp349j/vx1jThU+Ez9PWjI
	Zig6S1kZjWJ/8v4mKnIfaRd8Fbb5M0TEirzQ9WQXkHcruTcsBUkjgLs2gSTxb3Vn3x9yjvMp/+u
	9LdtjkI8AYpAlssiECPl7+O3tM8hIg1SlQCe+nGXWkZ5SmhNtnc4M1Hx5f+LRWwRto2EEQicoZJ
	gk+kbDSbytgVtyxbkttszX8ZazKnXeabL11YvnJh6tu6/YP+8pppjhrVP71dz7WLTiQveO1zEKH
	2uTjeW6IUAf4InymIzq10YqhM6SBnjGt1DWunb8hydi18PWa3m9ptLQWKK4cQL4G3bRf9rtV3tB
	1ZEhsW379d4WPRL3orCd5YMJ1c+q3g8SxsRCqmm5kJXtvNCOKL/g6w+oP/SCE8Oqb+3DuEfsucO
	VqhQlgqr5fRP9VIIs+HyweRyWkvM=
X-Received: by 2002:a05:600d:644d:20b0:4a1:b027:99ef with SMTP id 5b1f17b1804b1-4bb55a3f05cmr48662755e9.2.1794582667636;
        Fri, 13 Nov 2026 07:11:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5f350d51sm3215855e9.4.2026.11.13.07.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 07:11:06 -0800 (PST)
Message-ID: <2a362c31-2659-4a5d-a7b5-a50f646020b9@6wind.com>
Date: Fri, 13 Nov 2026 16:11:05 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v6] genetlink: Reject joining multicast groups no
 family owns
To: Anil Kaushik <anilkaushikwireless@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Florian Westphal <fw@strlen.de>,
 Mat Martineau <martineau@kernel.org>,
 XingWang Xiang <v3rdant.xiang@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
 linux-kernel@vger.kernel.org
References: <20261112094205.1120090-1-anilkaushikwireless@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20261112094205.1120090-1-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/11/2026 à 10:42, Anil Kaushik a écrit :
> genl_bind() checks the GENL_MCAST_CAP_* flags of a group only when a
> family owns it. For a group ID that no family owns, it returns 0, so any
> user can join it.
> 
> A family registered later can get that ID, and the socket stays a member:
> nothing checks it again. An unprivileged user can join the free IDs, load
> a family module with CTRL_CMD_GETFAMILY, which calls request_module(),
> and then receive the notifications of a group with
> GENL_MCAST_CAP_NET_ADMIN or GENL_MCAST_CAP_SYS_ADMIN. For example the
> drop_monitor "events" group always gets ID 1, and is free until the
> drop_monitor module is loaded.
> 
> Fix by returning -ENOENT from genl_bind() when no family owns the group.
> There are no group flags to check before the family registers, so this
> applies to privileged callers too: a program that joins a fixed ID such
> as NET_DM_GRP_ALERT before the family is loaded no longer gets its
> messages. I don't know of a program that does this. One that resolves
> the family first still joins.
> 
> bind() takes a mask of groups, and most IDs in it can have no owner. Such
> a mask used to work, so keep it working: netlink_bind() skips an ID when
> the bind callback returns -ENOENT, and joins the others. Only genl_bind()
> returns -ENOENT. A skipped ID is not joined, so it is no longer in the
> groups that getsockname() and NETLINK_LIST_MEMBERSHIPS report.
> setsockopt() returns the error, as it asks for one group.
> 
> This does not cover a family that is unregistered between the check and
> the point where the membership bit is set.
> 
> Found by the Sashiko review of the gtp multicast group fix. Tested as an
> unprivileged user who joins all free IDs, then loads gtp and
> drop_monitor:
> 
> Before:
>   joins: ok=62 EPERM=2
>   gtp/gtp (ID 15): member
>   NET_DM/events (ID 1): member
> 
> After:
>   joins: ok=19 ENOENT=43 EPERM=2
>   gtp/gtp (ID 15): not member
>   NET_DM/events (ID 1): not member
>   bind(), an owned group and free IDs: ok, member of the owned group only
> 
> genl_bind() was added, with its first capability check, in the commit
> in the Fixes tag.
> 
> Link: https://lore.kernel.org/netdev/179324692107.3134.14443689892607921337@kernel.org/
> Fixes: 4d54cc32112d ("mptcp: avoid lock_fast usage in accept path")
> Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
> ---
> v6:
> - Drop patch 2 of v5, as Jakub found it too ugly. A family unregistered
>   between the check and setting the membership bit is not covered.
> - Say that early joins to fixed IDs stop working, also for privileged
>   callers, and that NETLINK_LIST_MEMBERSHIPS changes.
> - Document the -ENOENT meaning on the bind member.
> - Rebase on net/main.
> 
> v5: https://lore.kernel.org/netdev/20261104092125.211537-1-anilkaushikwireless@gmail.com/
> 
> I used an LLM to help write and review the code, the tests and the
> commit message of this patch. I checked and tested every change myself.
Could these tests be added in selftests?
