Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DBE33C53F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885378; cv=none; b=VFP+fTGY0iMKH4M16vbEL7T2mAUlBHUOpD7iUIyNLwlBaqZL6M5S5TU1A+Vc/GgNstmSfoZ9pXoT8IDW3uSB0omOOytvr3l6DgEvSESi6HKFQ0NRT0+fR5HZ6Hne3aaKal/zhWFtwaKjoKH13IDGUimKjyE/kNiZz7rUn14n5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885378; c=relaxed/simple;
	bh=du69GUw1EIX5aANGYtoDtWVpbMocCveU908JccD8Dt8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=cQ6xbHEjXyiS6lcXk3JTvfLMPkWREE4fGC0iH/zKc4j5Sfq0UfpAgDsIwJAqZuw2uOCaRU9Sx2zCB04bgGRCOHv1fBC5GtnMt0BuuKeV4XZW0rKAe303WTRpkQSxKMxBTF4fjn2i+vYYgVYJutkO4vejqnBVkszsdf9ZlOBiDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xzx0XDdn; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xzx0XDdn"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9fa42f08cso269281a34.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782885374; x=1783490174; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMHc6VjC8zpAtFBxLHo9uqSmcB6QkUimxcvK+ODJl3o=;
        b=Xzx0XDdnzBkey9K1juzhg7Occmgf7fcUA4KNpLpW/FRtUI1gHOIRWCZRKKY5aTLfp+
         yTnon9oOc7eddpfQECZVqIKIiWi6M0hgBJyjaCcBcvqHFbDlZdx74RBGKJ16PhMpnpi3
         3D8OZkuZlQPZRmbDbTufJ9ZsWtaX5kXl1meWq2aIXqN/7pwZZ8/FoPpxWBDQwnKH5FHe
         rixh0B26doerafmmBgfiT9sBnYTZPag5f7WoxzwzePOayo/tHRa0rJCP85D19QPmFClW
         EU1CpJgF3MNSVQFrwMgwY0R7dW0MIPUc1bg2Pynaki1tQH2PbAF4RmCURaMAo/MqqIZk
         YuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782885374; x=1783490174;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMHc6VjC8zpAtFBxLHo9uqSmcB6QkUimxcvK+ODJl3o=;
        b=VdbPJUmJoq9yXls3znBfGl1jxzDw91/csdgxbNSNZ3+A4YZrgzLf2L9diTN+dcwExV
         q0U97Qne/yiI//65lt3FJv+bYuwibFTZw+hO9i8bkPAyE+FcbSSN4T+AgFeImGE9wj58
         2NqqjPrbAaLUyJWB92dZFC5ztEqQMesmHTvS6bQZTkBXUBHqEjF3pfBt7g3jFEHMGZ+p
         ZwMBaLwcNrBAUxKgX525C+ZpY/mARzc97j0xXNaDZCnVzESMRUZDYSSItcr0HYHRWC8c
         1UwhZFFRpCdwSKRoH2XomSi/zOTnA2R0EPK6f0AHooFrsT2315SIlnOBzCqimpCALpuV
         61oA==
X-Forwarded-Encrypted: i=1; AFNElJ/BVltUwExzsLtRkJKh0ijDrzm8Er0zsILbEDtc5A3uLTS8Xtuh6BxdljevF6Rz/QYXbx4/vcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjGHonjwOAGK0QWKnEaDaACj91k+0XBTGl4OvoPDvjFq+RUfvB
	sODAktmdznFcyIq9AdrfUckMGA9zdXZN1KrMDsv+pltnvCxnxr6bGEEyynHEgg==
X-Gm-Gg: AfdE7cmqL8hRzKPQMSt317GMduc0yOH5S72O9FLU3x4m2ajcp/2uDsBYw0o2BXydZi7
	gLr6asu7ENYbi8Qgra8Qz52MFbp6vigSqgkp3mrlicma7weS8FlQ3mqtl0PlvZrRBAqDDFbjbIT
	NaiBHimRCFrQg7yUW9XNA+Lnuw6wnySBjk8p6UyOz0uT5qKkBOfjc00PBP8aS7QrSZZ1/jyBznE
	kAUHaxxOmEfMLdY2FnqbMpykbmTdezCYBhcadO79iDhiyn83Bpp+GI5S/IgCKAxxr6jzvdgD/8X
	IkCQcJc+GDnSYrqPMv6gh7VrJZ+h8x31Ne+HdqOk0szxkjSTjWL3xR0u3WIfcf8M967FgVUfL4D
	mxbUxFHweQTg+ZAINF8LR1XcWVviO8RZ6KZ5GCkwmsyMpMDbGjh3hRorm0r0cfbQ82C/8aI5TGe
	SeHFXs6qtWnMW0HTZRuAAyHrigNUbSMCyAYJpNlXym19R7P6Ijn4zmjHVk9QDDyYrOv+OoXiEpc
	K0kMRI=
X-Received: by 2002:a05:6830:81d2:b0:7e9:eaf2:edff with SMTP id 46e09a7af769-7eb4cc4cb36mr45738a34.26.1782885374015;
        Tue, 30 Jun 2026 22:56:14 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5f::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec2e353fsm4114877a34.20.2026.06.30.22.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 22:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 22:56:11 -0700
Message-Id: <DJN048GYRBCZ.M83AO0MXTKSV@gmail.com>
Subject: Re: [PATCH v3 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "yonghong.song@linux.dev"
 <yonghong.song@linux.dev>, "song@kernel.org" <song@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "memxor@gmail.com" <memxor@gmail.com>, "shuah@kernel.org"
 <shuah@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
 <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "horms@kernel.org"
 <horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>, "kuniyu@google.com"
 <kuniyu@google.com>, "ij@kernel.org" <ij@kernel.org>,
 "ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
 <koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
 <g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
 <ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
 <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
 "rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com"
 <vidhi_goel@apple.com>
X-Mailer: aerc
References: <20260630120145.286497-1-chia-yu.chang@nokia-bell-labs.com>
 <DJMRPJEUTY5G.30HYOMPLBGZOJ@gmail.com>
 <PAXPR07MB7984443B70E713F016EAA550A3F62@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB7984443B70E713F016EAA550A3F62@PAXPR07MB7984.eurprd07.prod.outlook.com>

On Tue Jun 30, 2026 at 10:46 PM PDT, Chia-Yu Chang (Nokia) wrote:
>> > -     /* override sysctl_tcp_min_tso_segs (optional) */
>> > -     u32 (*min_tso_segs)(struct sock *sk);
>> > +     /*
>> > +      * Override tcp_tso_autosize (optional)
>> > +      *
>> > +      * If provided, this callback returns the final TSO segment numb=
er
>> > +      * and will bypass tcp_tso_autosize() entirely. The implementati=
on
>> > +      * must derive an appropriate value and ensure the result is val=
id.
>> > +      */
>> > +     u32 (*tso_segs)(struct sock *sk, u32 mss_now);
>>=20
>> I don't like this interface change.
>> It introduces churn for no good reason.
>> At least I don't see why you cannot live with the existing api.
>
> Hi Alexei,
>
> This patch was part of TCP Prague preparation series: https://lore.kernel=
.org/all/20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com/
> Our original patch is to add an extra tso_segs, and after discussion it's=
 recommended to replace exisiting min_tso_segs.
>
> This is needed because TCP Prague would set the exact TSO size rather tha=
n using autosizing from TCP.
> The TCP Prague itself is planned to be submitted after all preparation co=
mmits are accepted.
> You can find its current stauts: https://github.com/L4STeam/linux-net-nex=
t/blob/upstream_l4steam/net/ipv4/tcp_prague.c

You have to explain why Prague CC cannot rely on autosizing.
To me it sounds like a red flag. autosizing logic was there for a decade, i=
f not more.
And now you're arguing that your CC logic is special and it deserves new AP=
I
and breakage of existing convention.
Maybe you should step back and reconsider.

