Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957811;
	b=EKIWsNjomuP++0CjOwRtF7SEUrcrx8USG/2VwT2EWh2fuVLSlz/EX0HAvjm1n0TDVprk
	 bJvUTpKmI1SpDJX3UvQ0dSE/opbpkB70tPfV6KbIoOGMiMabsLTdJttMO/CSNwxqpQCIl
	 4hzsMFx7zJJhN5grcWZJC7QNEF9CXpVgEQB4vjwcwqbLUrHXUKtpRZvN8xdwyQB8FutFI
	 U+Ui18VfeFcbQs9xT2xYaxsac+I2TNONVaDChLuvLd6exseQ2+aCt7ebvLkhEOOkjKiVw
	 mjsby+iMXodKJMRRXqsKRR/4GlmjwPu0syflf46BnihqoqdNwEeBy2com2K9+LOcK+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=S9LGaEXB1E1wvy0Af1RCtMcyHpRCTnV7LkNTlfEWfg4=;
	b=g/e78qUb6/iDsV+8hFhEzmB39yRZyLUf4MiZXB0BHwdP3iawYPTt/XUGBFmmgdj1dmuX
	 CVHsMjJ7FpoYit1aMGqOErdGrYHnjFD1TTBCVT3cFmiUog1lCb5xCwSh22wquPGQ7OiuW
	 98BRcj3VsOteGwE0iuWIiDiO7Q5pf5W0gr16aJ+2VonsZiMv5m1fjbfwzztoYgXHW3mbS
	 RuE5eygrcZBQY15s+C9XnwnxAknigXTKiWlyZQrpm/5YX2MP2G81msZ2DtG2j9D3NbgT3
	 htvQzvC32dFKotFUxWf9PXKWZLSnKM/zHOCrC1S3j+UycN+IepXRfp2+RnpyosRGv1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JIayTWax;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8A606C3FA
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 09:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99C8A606C3FA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JIayTWax
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b596569640so642465a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 01:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793957809; x=1794562609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9LGaEXB1E1wvy0Af1RCtMcyHpRCTnV7LkNTlfEWfg4=;
        b=JIayTWaxp2ytSTWPaIY6LO9yPsbjTs0kZxLTxn3inu0yeGhmu0yciWY1nbphfxnkU2
         Som7MY8RIwdSxC69B2JzvMXw0aRXC1uUGW/HGPcfP4BM5tlp05yekHtfe0EmxLIlfFfw
         8Rq3y3hGojW4ToTct9lVzPzCpvmmMr32VJ51oPVny/RvV5Oq6kWz5Ie3xfqS8iGsWkvN
         ciDqEfwsta+BxSRaW4V2MUExt7EMPxo+Si84KMTZCa6wWKM1SMCUO8FhcFifSUC7VPkw
         Zwlj5aCbo0a1hfgNFg/cYBldyznyK0rH2+wki7bM+BNnhtDannIz3zriJi4icxf8eFbD
         lsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793957809; x=1794562609;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9LGaEXB1E1wvy0Af1RCtMcyHpRCTnV7LkNTlfEWfg4=;
        b=jAVzgrO2WnmYYnDyMQuG/wmgmzugo/MPsghGLJfTQhBCkhqX2Q/zYB6QpF8o78xsQz
         s+cmK62DBVv4hYdNGurN+3Sm6vwHTmHernL9lzoIhf7YE64a9YOVLewZG2ED1PwwDVjR
         jN5cNPk+7h5plxFVM0i3luv7hHznQIAZ679WGiDZKn5FPKQ+hAzq9q4AhM+sQbIqf9pn
         0N7Iw5RBrybJIz1YL9l8TCVglhhArRP9hEMCbgkoa1Afo3UKCyHcNJ+hwWXM+lvrKjvx
         Gqm791N+WUpwV8KYmbod/8OUpcNCpRW9mHMQsfFZqb8QpDa362DQ+W6jdf/D2qo/Hz3L
         GktA==
X-Gm-Message-State: APuU4Z/LFNAROZix54DTCqkgLznxP95ThfiiF1bbXI3w3U2Sd5z5JVMZ
	ZNzEtyX+llGW6MPRa+fvDHvpMuionJVgbLXPYCSKXrbZ+iT+1Q2SMl2FvNfC99BvZH8=
X-Gm-Gg: AYBFou3G2dt/XSMjXaQ5a8Dq0LNEDpeUoAEwezXSnk75NggawMiOvXQIrtwI7eOJBM+
	xZg8iwzCZb5pZPM/h1D6vglk1CACSOrpOZLvyn7DD3Tt3c4+PFV46+zSIeLfXbFI+o7k1v7oHOM
	Qkb3IELPRGmbVXXtOgz/2DSnNb4IHMaAm8NL3WV/sIalu64feXBBsVdJK+Og2nBN9/nPEHHODcR
	2ZoUwJ8f5I7Oe7ZK01ztb1qn2oXgEX/+e0S7ivC0oRL7k/mwkeiaQK+So1Zxc9Z5x+Fcl1HaiRR
	a4Knbot0uVNa3S8Jj4iBMZyfyDP0+cav+aJ/s7zUKUbJ4VOOJfIuADs/8oNZuErvAJgd48kF39s
	tpQSe5TZtqcf0zCvnqTzJJkwCjL/XYrUldDlTla/TTIzxAJhqeENeF6ymDuIETTrgHtKfIBOh/i
	DpQOxCqhenPFlTgw2Xp3m0GS6oD33HRaOD3hCP81dZJGqeRD34qsdVWbVN9kKhZG/xwD6tC/unT
	VvWyDAZoq5R2aDvrlAKrvO/f/BXwlceiX8etNaZgKv6vrq9xmHzppmpkpFT8JBtq6P3MialIjRa
	bjovJIDKYBQ7EU8AIzPGeV6DRdLT1jlUsrSDn8Q7NvBT72gx/AXxpfYz+CJtUPYx/x7fB6dfzop
	6/yfUZOZS8CdIGA==
X-Received: by 2002:a05:6402:5d5:b0:6b1:c521:ebda with SMTP id 4fb4d7f45d1cf-6b5977f69bamr1395049a12.14.1793957808889;
        Fri, 06 Nov 2026 01:36:48 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be. [194.78.224.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b65d6b3a1csm523809a12.2.2026.11.06.01.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:36:48 -0800 (PST)
Date: Fri, 6 Nov 2026 10:36:46 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Stefano
 Garzarella <sgarzare@redhat.com>, <virtualization@lists.linux.dev>, Bobby
 Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH RFC iproute2-next 2/2] ip: add "ip vsock" to move the
 guest vsock device to a netns
Message-ID: <20261106103646.41a0f13a@stephen-xps.local>
In-Reply-To: <20261105-vsock-guest-ns-v1-2-b1c11b3b69c7@meta.com>
References: <20261105-vsock-guest-ns-v1-0-b1c11b3b69c7@meta.com>
	<20261105-vsock-guest-ns-v1-2-b1c11b3b69c7@meta.com>
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

On Thu, 5 Nov 2026 11:30:36 -0800
Bobby Eshleman <bobbyeshleman@meta.com> wrote:

> The guest's vsock device is not a netdev, so rtnetlink cannot move it
> between network namespaces. Add an "ip vsock" object that goes through
> the "vsock" generic netlink family instead:
> 
>   ip vsock set netns { PID | NETNSNAME | NETNSFILE }
>   ip vsock show
> 
> "set" issues VSOCK_CMD_DEV_NETNS_SET from inside the target namespace,
> since the kernel moves the device to the namespace the request was sent
> from. "show" issues VSOCK_CMD_DEV_NETNS_GET and prints where the device
> is, relative to the current namespace.
> 
> Link: https://lore.kernel.org/all/20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com/
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---

Semi-automated review using review-prompts for iproute2


On Thu, 5 Nov 2026 11:30:36 -0800, Bobby Eshleman wrote:

Thanks, this is mostly in good shape. A few things to fix before it
goes beyond RFC.

> +#include <linux/vsock_netlink.h>

This depends on a uapi header (and kernel series) that is not yet
merged. iproute2-next can only take this once the kernel side is in
net-next; the header update should then come from the normal uapi
sync rather than a hand-added copy in patch 1/2.

> +static int vsock_talk(__u8 cmd, struct nlmsghdr **answer)
> +{
> +	GENL_REQUEST(req, 128, 0, 0, VSOCK_FAMILY_VERSION, cmd, NLM_F_REQUEST);
> +	struct rtnl_handle grth = { .fd = -1 };
> +	int family = -1;
> +	int ret;
> +
> +	if (genl_init_handle(&grth, VSOCK_FAMILY_NAME, &family)) {
> +		fprintf(stderr,
> +			"Cannot resolve the \"%s\" netlink family, the kernel may not support moving the vsock device.\n",
> +			VSOCK_FAMILY_NAME);
> +		return -1;
> +	}

genl_init_handle() leaves the socket open when genl_resolve_family()
fails, so this leaks grth.fd. Harmless today since ip exits, but not
under "ip -batch". Add rtnl_close(&grth) on this path.

Also genl_resolve_family() already prints "Error talking to the kernel"
on failure, so the user gets two messages. Not a big deal, just be aware.

> +static void vsock_print_netnsid(int id)
> +{
> +	char *name;
> +
> +	if (is_json_context()) {
> +		print_int(PRINT_JSON, "netnsid", NULL, id);
> +		return;
> +	}

This copies the IFLA_LINK_NETNSID pattern from ipaddress.c, which is
fine for consistency, but note that JSON users never get the netns
name and get -1 for "unknown". Consider also emitting
print_string(PRINT_JSON, "netns", NULL, name) when a name exists.

> +int do_ipvsock(int argc, char **argv)
> +{
> +	if (argc < 1)
> +		return vsock_dev_netns_show();
> +
> +	if (matches(*argv, "show") == 0 ||
> +	    matches(*argv, "list") == 0) {
...
> +	if (matches(*argv, "set") == 0)
...
> +	if (matches(*argv, "help") == 0)
> +		usage();

and in vsock_set():

> +		} else if (matches(*argv, "help") == 0) {

New code must use strcmp(), not matches(). Abbreviation matching has
caused repeated breakage when keywords are added later (e.g. "s" here
already matches both "show" and "set"; order decides which wins).
Please convert all of these to strcmp().

> +	ret = rtnl_talk(&grth, &req.n, answer);
> +	rtnl_close(&grth);
> +
> +	return ret < 0 ? -2 : 0;

The -2 propagates out as the exit status of ip (254). Other ip
subcommands return -1/1 on failure; either is fine but please be
consistent with vsock_dev_netns_set() which returns -1 for its own
errors and -2 for a kernel error.

> +		"Usage:	ip vsock set netns { PID | NETNSNAME | NETNSFILE }\n"
> +		"	ip vsock show\n");

Literal tabs in the usage string; the rest of ip uses spaces for
alignment here ("Usage: ip vsock ...\n       ip vsock show\n").
Also "ip vsock help" should be listed.

> +static int vsock_dev_netns_set(const char *netns)
> +{
...
> +	if (setns(netns_fd, CLONE_NEWNET) < 0) {

Design note, more for the kernel side than this patch: because
VSOCK_CMD_DEV_NETNS_SET has no target attribute, userspace has to do a
setns() dance, and "ip -n foo vsock set netns bar" ends up depending on
which namespace the genl socket was opened in. rtnetlink and devlink
both take an explicit NETNS_FD / NETNS_PID / NETNS_ID attribute for
this; doing the same for vsock would make the tool trivial and avoid
needing setns() (and the privileges to enter the target ns) at all.
Since this is RFC on both sides it seems worth reconsidering now.

If the kernel API stays as is, the setns/restore logic looks correct.

> +ip vsock set netns 1
> +.RS 4
> +Move the device back to the initial network namespace, undoing the assignment.

That only holds if ip is run in the initial pid namespace; "1" is a
PID, not "the initial netns". Maybe say so, or use /proc/1/ns/net.

Minor: the man page says "Nothing follows vsock when the device is in
the current namespace" -- worth also showing an example of the
"netnsid unknown" output so users know what it means.
