Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895487;
	b=egskUF9n5k/Bl33qvPvg7aly2GQezahL3zMM5XJAWti4PlvGxIoIyFetlIoGF6qRyhLB
	 feWFhIcmvsqdf903ztzABrd7feWnM4F+QkL4At7qtMlq7D8wbpmd2TZ+GsVuL65Eh+PQg
	 3OegfRn9ukKUpoTPTC+GeBe+hnlyebXZFmiD3KFV20OcSX6d29JEAhvhXyKBEbdhOPWks
	 Ga9P3OVdZGfv+mDfsj0ftARTRrKSV2qGWpzbsVwM2D5H2NrH65Fewb1zsWNJ5uT40DOnL
	 5VIIX0NmiYuPhvkho2xrBN99tV/CsDnheGo3gPP7Yi17l/VITX35+VmrQcqX2eIPsJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895487;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=5btkYgoCas6QGdDdEV99M1LT/zc64JzXRUD+6MRR7mA=;
	b=sckNVfWHx6ht3eeoPT4wn+pgKChiksLPMnKMbwFah1Wpy3kh4QQ4dEol7oaNJ5I4lFkx
	 3nWyGKZ1WGlrq1VMalmR4i2ZDhmgaBVA6iV77NCDpycl213Z9LJVRXvwhq/ZreMyxe/ti
	 MPj6epBnwQfoIMEdxRjzfaigVxQbBBFKZPOEHOaflQjfFVk60I3JNamr80nkVODc+3EFv
	 q4Z2FJO9j+J6RH45Q+bkYUwU9vjQcjOJwaNIGUIl+52HQ9lFPboiFOEnBDXx8jceiWlxZ
	 ic6iqrPFGX5itvMzNVG+MMfNyxWbmIp8F3wG+7EUKUbDYCy97pazeur1Xxkg0EBhhPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S5iL25OR;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=icvQ0q2+;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940CE606A33C
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 16:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 940CE606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S5iL25OR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=icvQ0q2+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793895485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5btkYgoCas6QGdDdEV99M1LT/zc64JzXRUD+6MRR7mA=;
	b=S5iL25ORlwfJuyOEN20HyeCp3FYVI8Da+tnY98mDd6yHCFiZeCpRc4Gc9t1btRzuXhPXdr
	1vHHdOPborJtspGTx7Q/wd3GVSd3W4icgpgoKTU+MzMOV46tk90IJwsXyR8lqJu+8nivMO
	O/D9e2qBUAT1LpxCxUynfqW6uQ3Xkc4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-1_cXzBOoMfGfkmd6LXAxcg-1; Thu, 05 Nov 2026 11:18:04 -0500
X-MC-Unique: 1_cXzBOoMfGfkmd6LXAxcg-1
X-Mimecast-MFC-AGG-ID: 1_cXzBOoMfGfkmd6LXAxcg_1793895483
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4afef353dd2so28663535e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 08:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793895483; x=1794500283; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5btkYgoCas6QGdDdEV99M1LT/zc64JzXRUD+6MRR7mA=;
        b=icvQ0q2+/7npzbgW8GUq9laWEqHVJNMxVd2QK4Wx6lFoO4gsSt+lmep30txehm6dLJ
         SDFHV9B2Fzzoa4DMvjCiXN8NvHAWJUoqnY1BTNtLQ12c+A5AFwpYtRwy6Xt5ItYYPVFJ
         CxUusrqa3wnbpdD8LhTemA21wRrKMsjRNW5rgrWImFtMVstDVRbEURaH7goNjNKpeoba
         x3y77F0yAse/oOOCKxhGUE2rkkQgq5rUr4ybrdyu9TF2HBm3ZU8atbodbkRXW+h8DkB1
         Li48htykwc7VjByZnpGIz/PT1ndhJjv9DHpbaMEPZV1Gy2itwLbro/xzhash9WTqPuNG
         A5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793895483; x=1794500283;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5btkYgoCas6QGdDdEV99M1LT/zc64JzXRUD+6MRR7mA=;
        b=D0twxoV4DkUqM9ThHb6XeSMuypNpm1YFWzYs39MnhslZ/gLN4pP/aht9mokq5I6WjB
         PHP7fWf9+W8ZRgWV3LJCyOHHPEYqSm+7j90nLbtIMYsBQ4WRT22iuLofwsDHmhzTNDvY
         7rYNfGqZM3uRVCZYPQsmL2xOu5fQt45OY/t+NpNWDEukIpXC10+ZrElWqyUFjC4FwGv+
         8saVR/5ITZKo+49EWY74Zov66VEQ9ffzIqILbyQeFUIAl61muCGcMXtq7+xRFDPqnjiU
         NMYfIBJq/v4lJyIDmYLO55+djWsa7yXrBN/VJnF37jrcf90oERv8quSjqpgM0CjaZnw2
         8EhQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpA1EIN+YLG4zvF45wV5O9CAJxvb2bumCh0v+apl9maMzrxYa/o7nbVRJ0j//T4COXOmXtffg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+waDPOjCDp/J7yGSg8CsLPB7/6I+msS9rcbXHicrYPj2mAEj4z
	9GkTGiicIVBJiL7UM1zBfR+IIZnOcdJEXPfzcZ7PD2EQ1122bigY2fB8snvv6kLz3Sgyy1hdL6s
	yecuH6goIKZQSFgkSm/msuUP7ll6JsobvSYJo4QZcW6F+zhIDJDoBHEgfNg==
X-Gm-Gg: AYBFou3VDDFxgwWw335WJJVm/0WXpdsqPAoxeC81HHbSsTQGYT3PUtbFfRknvGFpt1h
	+fNqXFaRrQ1k2nh2TdHW+XsLWHMsUqF1H13V0NbHMYIZNo/izZrkRUKpql8SUBAlqPQXu7Bsvkg
	Zj0gA4jpzcCPqqhJGzPDV3Y3z6qbKzlXNxWxIwYti53vBwjv74BlngGRilano5m++E7GKusnaA8
	UhP7gAPEJnvIIe/frHD4F0C/81+nAuHHqYkjvxbteC7PGgTtHTevhAPhfrUrqWYY2Ol1cMR1Q14
	CKDj/ggitR0fsk7GpxDxn1j76t2DJuygNdqjx9y2Y8JjpkytDvTkphes3RkFVup9XaMC8XNdluk
	yNrtfTSGMXYasDKjWHUxbb01XvMSQ14ysV8mh5s9T3X+0hOgzLxk9gRhhE7zTd5qZC5rBuWhgqV
	XZvA==
X-Received: by 2002:a05:600c:4715:b0:4a3:598e:e7a8 with SMTP id 5b1f17b1804b1-4ac150b28bamr440224565e9.4.1793895483082;
        Thu, 05 Nov 2026 08:18:03 -0800 (PST)
X-Received: by 2002:a05:600c:4715:b0:4a3:598e:e7a8 with SMTP id 5b1f17b1804b1-4ac150b28bamr440224145e9.4.1793895482697;
        Thu, 05 Nov 2026 08:18:02 -0800 (PST)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([213.157.19.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56fca22f4sm124635795e9.13.2026.11.05.08.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:18:00 -0800 (PST)
From: Aaron Conole <aconole@redhat.com>
To: Joas Antonio dos Santos via B4 Relay
 <devnull+joasantonio108.gmail.com@kernel.org>
Cc: Eelco Chaudron <echaudro@redhat.com>,  Ilya Maximets
 <i.maximets@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  joasantonio108@gmail.com,  netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH net v2] openvswitch: advance by the real header length
 in get_ipv6_ext_hdrs()
In-Reply-To: <20261102-ovs-exthdrs-v2-1-21ceef6a243d@gmail.com> (Joas Antonio
	dos Santos via's message of "Mon, 02 Nov 2026 01:45:35 +0000")
References: <20261102-ovs-exthdrs-v2-1-21ceef6a243d@gmail.com>
Date: Thu, 05 Nov 2026 11:17:59 -0500
Message-ID: <f7tqzgz8d6w.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Joas Antonio dos Santos via B4 Relay
<devnull+joasantonio108.gmail.com@kernel.org> writes:

> From: Joas Antonio dos Santos <joasantonio108@gmail.com>
>
> get_ipv6_ext_hdrs() walks the IPv6 extension header chain to fill
> key->ipv6.exthdrs, but advances to the next header with ipv6_optlen()
> whatever the current header is.  That is only right for Hop-by-Hop,
> Destination Options and Routing headers:
>
>  - an Authentication Header is ((hdrlen + 2) << 2) bytes long
>    (ipv6_authlen()), so with hdrlen = 4 the walk skips 40 bytes instead
>    of 24 and reads the next "header" from the ICV and payload;
>
>  - a Fragment header is always 8 bytes, and the byte read as hdrlen is
>    its Reserved field, which the sender controls and receivers ignore,
>    so a non-zero value makes the walk skip up to 2048 bytes and miss
>    the headers that follow;
>
>  - in a non-first fragment nothing after the Fragment header is a
>    header at all, it is the middle of the fragmentable part, yet the
>    walk keeps parsing it as an extension header chain.
>
> In all cases the OFPIEH12_* bits stored in key->ipv6.exthdrs depend on
> bytes chosen by the sender rather than on the headers that are actually
> present: payload bytes that look like another AH or a Hop-by-Hop header
> add OFPIEH12_UNREP/OFPIEH12_UNSEQ, and real headers after a Fragment
> header can go unreported.  Flows that match on OVS_KEY_ATTR_IPV6_EXTHDRS
> then classify such packets wrongly.  There is no memory safety issue,
> skb_header_pointer() bounds every read.
>
> Advance by sizeof(struct frag_hdr) for Fragment headers and by
> ipv6_authlen() for AH, and stop at the Fragment header if its offset is
> non-zero, as ipv6_find_hdr() does.
>
> Fixes: 28a3f0601727 ("net: openvswitch: IPv6: Add IPv6 extension header support")
> Link: https://lore.kernel.org/all/178905555085.219967.6617611783437228045@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

