Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293666;
	b=l30/z+ijRO13SU3sfvTlj3il/mNK/6NTpNfG7BusHZpIq/Q45A1Vdd3fzfQDyXp0/XfK
	 VrZAYO4Ggmb8XFFHoAUP7/lXRuzJULiEDXmzCvRgyok0/VEn4lCkdSyqUsHu6ynYkd2M+
	 Ba2Ns62YlYVvzapK536wL/kVZWemqT/B7UE18XirXZRBr9W+JI9ml099K1wXa5J6Z7mzN
	 gsf0X2ncEsLlOSxvtHiC44yqiZZU9LUVEohPJtGknrInkXCvyjbY8ro15vfwyQ1Mgg7yY
	 JJr5/qcmPn0iIHydqIC7R9gIMfwr6yE5FrC07wVUMrIQ+4R7KMeC7cVERCqZRCdn+BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YrIvLuA1wyST/7aXpQifCmPyW3zDPCfgAxFq045oxok=;
	b=wY68kuGQqiYGSp0dPe/7D9Sgc782AKmF/BTX28Or5vmnvCueorGeF5yZ+5iEtBR615aa
	 BC7tzn3pInEq8xnCb5YOuxlvBEXyOjjfZ4Ero427vSXbc6yCevjmYpiX/1wPrc+8XU1zP
	 AwTEmadhF3Xx5AHq3LnQ9RBo9rZOd9t7JWpGQ1SRLWHAhel9W7b7TfW30pfXEncBL76bm
	 cKUpp6ogI3b85+uyh6AlkioxTUOmE4heih+EtXs4PaZCCLVFrcbljCUP+5BEsVKLn3sA3
	 GpIFfKufHJCuw/h3I3yytSKzivfB6w85PHVyYkE/ZgcRkV2/oQ3swu2dmZezmueto6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YePCjWy0;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7834606A31E
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7834606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YePCjWy0
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae486f8a27so1607006a91.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793293665; x=1793898465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YrIvLuA1wyST/7aXpQifCmPyW3zDPCfgAxFq045oxok=;
        b=YePCjWy08EW4+qzkolraE2Y/PeoOR33a6KU5gPwfbipI2Vpe5edh5CHNE14yWhNPxw
         gbCe5IEDYZxWRmeFnYOUXZdC4kNQtaIKtOOC6ZmTLLBqLvEL7Iqv1gvLcve0eJj4iqM+
         NDKcdzTSFd2IJ+Ynx92SJIGzhJS+mX/0KqQCoJ4ye9zyAVQ1sX3qBsv49T7062Gucpuq
         YWb6IZCN0IWpXccdPBvf6bnOS+jtdg73mvDGaX1AYKAd4DGg9hyIn/gWPG+DLnRTCU2z
         qrE3Jjqf3z52bWhnl/5Ra5Usvugzrmt0RMht9npxkyPPzDuqhLZC0xZGHRLzmXVNE6kG
         9aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293665; x=1793898465;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YrIvLuA1wyST/7aXpQifCmPyW3zDPCfgAxFq045oxok=;
        b=S+W3OESQyeCxWRdJiw1fxor5EvwdtDZHiVv7Cqx0esv6ByMtmH6YL2Y2LAbUYQv7Hm
         +Rwrg9TrVVyBWOy4VK6HzSOwvHV3BPtZLfMK3bQ1GMeJYXr8pZqe1iz1slPTZzp9Ggou
         e2nUfaI93RDBQUxMKJWG0b4ie1cU5hP69TQtJc0+tHZq4RNAw2A5mUBBphAqojzWv2JP
         NeNtPeAZ2G0wjgA/a+EPzsQ4aEZvnrCwwdwM2XH7NxvzVf3ih4qBFYOFg7KWKQevIjSb
         Qy27lG7u1wLr1MMivWCG8bJYfUeD2IPmt4OtETFN5rvyrGNkER4qlJPSBm5vc8TuXpmq
         tA3A==
X-Forwarded-Encrypted: i=1; AKwUvByjVJjlUWSIywe30XeQALNQB2vTNtsocHeolR0TtDqGcP1vELDZLy5sheUSesMIDra/qmQolqI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJ/9hCu6pNgPS6CSj7kbBfvHwek8CjX3FOv6/KD11r56qAFFuz
	oz84lBQdrXEEk3x3MfIVUU7lkTNrqKD9mRXEgtqWAxv332bJRKlzjEMhlLPZ7j9ea50=
X-Gm-Gg: AYBFou1lGKjhBWGjTRpwYudA0C0D1CLzzSP5Tf4ErBPje+o1/4ADusLV7oUioRjvxcS
	hw+dRmDxNh0+EaJkcWWBccdEIg62RH2YRCOjDGp9n7IRTQB6juiTuNTfxn5sgyRSLEbYgHWjKru
	hT5tkqBTkmGZn3qj5aPLogRX2UK9DHG8xpXrxY/i1LSP0y6/fPiA9EtoMwn0A02ae4BBo0ja1yu
	KrBKrH5E1FEk1SCvZGR5/ZAvD0YAVqK1E/cSJsySRl9ixN+KYyx4rcIKihxQYAOZ3I5CFREHlhy
	vLM9dxtzaP9yYrhYXiFcPIrolMmxvYEBkul5tJJ31IqGysK1GTpmk95ABPCR3cC3UHp9vjemnXR
	i/ijZ3SHHubgkOrm9XsxZ/bI+xJOBfZhKv6XEZ2/ZTDMjz7jz/z/DsoSPnVwMvjIHXKaMGbUeX/
	rsQ6YiG6hMEkS5z7/DD9vmfXXaf0ZwWpjMQLItF644vJeAArSpYUXYSJBF0kIJAYovSyNDrXLXv
	ONsK00H/eCRuY87dKB2WJ1DvoHG8GOhfCic9aPPnCOytN9DZEw66DxwJdFWDBs1JvFPZ7703nwO
	fyDdooaM94ktli7z7IJ4WO0jYzod3Zc4b5hkIsfgAfNEM7IjZleEGD4O5ECsAk9aIDIIdDQ=
X-Received: by 2002:a17:90b:1c01:b0:3ac:7842:bd50 with SMTP id 98e67ed59e1d1-3ae57f63826mr4385204a91.15.1793293664880;
        Thu, 29 Oct 2026 10:07:44 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8441a6f0sm465323a91.1.2026.10.29.10.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:07:44 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:07:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-net] mptcp: limits: fix JSON support
Message-ID: <20261029100741.3cd38216@phoenix.local>
In-Reply-To: <20261029-mptcp-limits-json-v1-1-7ac73cdab054@kernel.org>
References: <20261029-mptcp-limits-json-v1-1-7ac73cdab054@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 14:17:42 +0100
"Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:

> print_mptcp_limit() was trying to open a JSON sub-object and closing it,
> but no JSON object was actually created before.
> 
> Because of that, JSON support was working with the MPTCP limits:
> 
>   $ ip -j mptcp limits show
>   add_addr_accepted 0 subflows 2
> 
> Create a plain object before calling print_mptcp_limit: an array is not
> needed here because all limits have a different name.
> 
> After this modification, we now have:
> 
>   $ ip -j mptcp limits show | jq
>   {
>     "add_addr_accepted": 0,
>     "subflows": 2
>   }
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

Should be the regular json_obj variants, not the _plain ones
here.

The AI response was:

On Thu, 29 Oct 2026 14:17:42 +0100, Matthieu Baerts (NGI0) wrote:
> print_mptcp_limit() was trying to open a JSON sub-object and closing it,
> but no JSON object was actually created before.

Right, and that part of the diagnosis is correct -- the open_json_object()
and close_json_object() calls in print_mptcp_limit() were silent no-ops
because no writer existed. Thanks for catching it.

> Create a plain object before calling print_mptcp_limit: an array is not
> needed here because all limits have a different name.

This is where I'd push back. An array isn't needed in the sense that there
is only ever one object, but it is what every other "ip" subcommand emits,
including the other three JSON sites in this same file:

	ip/ipmptcp.c:317	new_json_obj(json)	mptcp_addr_dump()
	ip/ipmptcp.c:345	new_json_obj(json)	mptcp_addr_show()
	ip/ipmptcp.c:611	new_json_obj(json)	mptcp_monitor()

So after this patch "ip mptcp" is inconsistent with itself:

	$ ip -j mptcp endpoint show
	[]
	$ ip -j mptcp limits show
	{"add_addr_accepted":0,"subflows":2}

The _plain variant exists for the standalone utilities that have their own
output conventions -- dcb, devlink, dpll, nstat, ifstat, lnstat, vdpa. It
is not used anywhere else under ip/, and I'd rather it stayed that way.

> +		new_json_obj_plain(json);
>  		ret = print_mptcp_limit(answer, stdout);
> +		delete_json_obj_plain();

Please use the regular pair instead:

		new_json_obj(json);
		ret = print_mptcp_limit(answer, stdout);
		delete_json_obj();

which gives

	$ ip -j mptcp limits show
	[{"add_addr_accepted":0,"subflows":2}]
	$ ip -j -p mptcp limits show
	[
	    {
	        "add_addr_accepted": 0,
	        "subflows": 2
	    }
	]

No other change is needed: print_mptcp_limit() already calls
open_json_object(NULL), which is required either way -- under an array it
creates the element object, under _plain it created the root object. Plain
text output is unchanged in both versions.

Worth doing now rather than later: JSON output for the limits never worked,
so nothing can be depending on the current shape yet. I checked the mptcp
selftests as the likely consumer and they parse text only --
pm_netlink.sh:71 does

	ip -n "${ns1}" mptcp limits | awk '{ print $2" "$4 }'

with no -j or --json use anywhere under selftests/net/mptcp/ (the only jq
there parses nft output in mptcp_sockopt.sh). So the shape is still free to
change; once it ships in a release it isn't.

One nit in the commit message while you're respinning:

> Because of that, JSON support was working with the MPTCP limits:

Missing a negation -- "was not working". The example output just below makes
the intent clear, so this alone wouldn't be worth a v2.
