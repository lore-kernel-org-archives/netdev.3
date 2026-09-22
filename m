Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE94A5EA4
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057297; cv=pass; b=K0YEnZWXnB8J3D4Z+LXapguLHD25ZGtM8Mq1IEUp8LDuHF9jnXMthydS+GIuTXkx4E66Fm5O28KFdrrqEt289aW8oPToVz2K9Gfv2QZRpEG65cyQvomeI3EesyRJdkOADcGipyibuyoiSmEZq3xBXoYCWMZ49yfSK2pbJEQQuWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057297; c=relaxed/simple;
	bh=lU4+cJqD/nNdngY9jcwbIF3YP9+U3EvgKauYeL8nv3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsbtSUnRS4UdVyTbXehjUtg8yoNT7RZ0xmHDkvl3KOCwm4ollKCjCmZa7GnutmhK6t3B45p85tcHfX/SBTNIgK0+Ajgyb/VqN8TpGzPICXKjCntNnw/SNf7jr9rt328CrHW8XEYRLff+gHgyz4LL1rIJL2P/zEcKJxvNQqduq40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7o66xOh; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7o66xOh"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c5so2866068f8f.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 23:08:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790057294; cv=none;
        d=google.com; s=arc-20260327;
        b=gXcxQ4+lKnlI3VfSaTCclJjggvKSrfqr0bqDyW1zkY4a68JkxapWrbwJNPmlv1DTZM
         +I+adWY77hpkfHcwsiGbYtnwyr8+ieejc4GlxbrgFvU4z41Aui7leXb14cQaDmRGao0u
         fbSpyqzeCyc1JAbwr9AP4LiTYTOIXCYmJMrmE9/pVtDCnXZa1nt+8ehC6GpEs9HG21hM
         y1MN6OnMqGUS+Teq5MT8prqTFZCPqurKeUiqJdzprb2UrYXQNSSJp2mHeS68mX8QGyMQ
         EphjwYqkESSnR1iU416poHkBayDctDy39zRJT7HsSfU74KerVkJbODZzegvaeln6PUPJ
         eUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lU4+cJqD/nNdngY9jcwbIF3YP9+U3EvgKauYeL8nv3Y=;
        fh=JDLncIv4b1ljfA5j2kCK5zI8iXSW5ni0RpE77ZNFeOU=;
        b=ctTd6mwK7+HPepnOiRPpEuHeN3OHiFsuyQl8E1w/rhuczw51gubzAc0A2aYmIWdVvd
         2xTUPigfttjcWsQdZ8KuntEMsh4nSlkmRUMdrbzHdT5VIHEfk+Zbqptsfpa+OJGCJkM9
         6T/HGBXlwwFZ1Wz5n+bCrVpMaUbaSQlJQAVcTDfS/vhIT+veQpZj5K5n3+7dsLFQV0Oq
         0lqHhRJtYa7gXm/LEl4vyiUiSWpDTvWV18ss80JJZx0pKm0SEfExaW5KUIJSe8dXpKQE
         LmRFVnHrXSJe63b/Kief2bKlL9fQ4NejqcS0nXxhr4bbPkXjwXKdCpVNzdjC2ZQmo384
         ZPMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790057294; x=1790662094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lU4+cJqD/nNdngY9jcwbIF3YP9+U3EvgKauYeL8nv3Y=;
        b=n7o66xOh2geGJFF7Egtfk005j/bjOKadlFXEBURGCGMidFQslP4iu9WgkJvRvumiDs
         RakR2ENIuIL0rYsQwTvD1C29WM7j6xRC51h4uF57CJK7q5dAe9E0QvQpvcOz54lAmXNl
         KSg6ePpcIUht32HnH2+OH9kMqhtg3IoISWotL9EkGvmcDa8NyC1d1izUPcn19HUGACWv
         AVW3PD6cfY4T2iqSxf3RGTFU2J9ZLdl9VqLoJ259LzMuzEQ4HpChQeXLEGX606SCGcOC
         gbhkwSlvP9Tcpv6lVQsHUzdMa8mW1f8MnLWnaJa0gIV6goBVkIkkZTmcMGeUsuxnm/hU
         5tnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790057294; x=1790662094;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lU4+cJqD/nNdngY9jcwbIF3YP9+U3EvgKauYeL8nv3Y=;
        b=WOFImdNsULYnmYCXZaZSfaT8XkJU0UeRjYkmSk5mJgwYmdAiHpnlucHBwjg6z1e4nK
         AcgfhUWrzzODo9XwVfL7AyADJ9Jw61LxzvqnJEfXb1FGVNwRFUvNK/5+SkErDvuwDkV5
         xMTymmHl6W1fWO6BxnYeMEABLl/M/cN4/T2IPDRzZ7bVNMpH/McMXcZIjfyLrrjLW5so
         Wws7MIJTnSGraVcixD+Jm96VS8/jSo1iZ3Dfu/i/2EmWuvDAYV4gzD8hWdcrUGqLgUGS
         AYK3/sD8FfiRTMsI642uThzMJp0SNamQd3fXMgCjooICR2jH1ooky2KPWTuiQedOQJkm
         dFCw==
X-Forwarded-Encrypted: i=1; AKwUvBz6EBdu5MueKqJbDAQAJJzUx/JU00Q24/pqh/mzEgAUJQbTOQYYQobhGqWTtUUC6RY9F5u9p+I=@vger.kernel.org
X-Gm-Message-State: AFuF++mnMS8uOccF2Qxf5giiBrxQjbNp6RHvkiovAVePGa89AMlMDWIT
	ORarEyfbr+oo1I3K8+fg2huMFyICox/1tXz9fTHwIcSuRVTSQnAuuBScaVeeIKpL8XTnl1m/mcC
	24Xgg41uKbzPdp2SZyPDBQMKCDmeCx9fxLfdBMiqV
X-Gm-Gg: AYBFou0zQfYMsftL0RHFU4/DNKlEuGiqHT4b59M9fUPGrIJFQjC5gKx3K90GWPf+lbi
	Qvitfq6TlW1Y/nUqcV3ljXp59SBHhz2Pns5gtLFYxFoqYnNnKMYIjSOO7dSksxXSst3h5/5hTYz
	h+5h4NWqnk1XfdLUyQW38Sx3M/ML+wrIBYUw0z+1v2oh5iIZyGSAQd0WvCOlIsj21iEzpWWjzLF
	oMNqMxbbnKM6mKCqtqxtu4JgqyfYYwLDxjpWN6VDyMxq2MTQqjkKejsGuqU5RWPd/rGnytcZwNv
	UCSR4P0amrSEmEFS3bKB1BvnHzw+sJKgQyZcVhjNzf0ukuyXqbFtG5fyX99ksiPFrbzH8I872CP
	p5hDR3yNUX2S2GObrC+0s8XuqiUfamxM=
X-Received: by 2002:a05:6000:220e:b0:486:ecc3:2d1a with SMTP id
 ffacd0b85a97d-4871e269d01mr19262668f8f.31.1790057293398; Mon, 21 Sep 2026
 23:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918100016.100988-1-sagartaunk@proton.me> <KZuCCqRjSSbylbLLVhoUD9-xyBpzD9jUB4vGC16N0_hIra8SNxFeh9lEJ6FIMYMgKqf41J_swYT_HVx3w13k0cSrYYkBljOF56suy3gpgAU=@proton.me>
In-Reply-To: <KZuCCqRjSSbylbLLVhoUD9-xyBpzD9jUB4vGC16N0_hIra8SNxFeh9lEJ6FIMYMgKqf41J_swYT_HVx3w13k0cSrYYkBljOF56suy3gpgAU=@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 22 Sep 2026 08:07:59 +0200
X-Gm-Features: AcwNN1UppsBdP80xwxwz1vqmCSvIj2SXiUZijx9yJ0g1QECx8Yr30-wQ14vxhbg
Message-ID: <CAH5fLgiCrx=XkMETY8eCMTXwpCJiJRGRkdujR5WqQfd=GVrkUQ@mail.gmail.com>
Subject: Re: [PATCH net v3] rust: net: netlink: validate attribute length
 before casting to `c_int`
To: Sagar Taunk <sagartaunk@proton.me>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Matthew Maurer <mmaurer@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 4:31=E2=80=AFAM Sagar Taunk <sagartaunk@proton.me> =
wrote:
>
>
>
>
> Hello, are there any updates for this?
>
> Also, I wanted to ask is it fine if I keep fixing stuff pointed out by sa=
shiko for now ? (I.e pre-existing issues pointed out by it in other's patch=
es or should I ask the original authors of it first ?)

You already added my Reviewed-by, and I'm ok with the patch, so for
now we're just waiting for netdev to pick it up.

You're welcome to patch things pointed out by sashiko if they're real
issues. But note that sashiko can make mistakes, so if you're not sure
that something is a bug, it may be better to ask first.

Alice
