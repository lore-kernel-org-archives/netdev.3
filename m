Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC62555D88C;
	Wed, 23 Sep 2026 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177525; cv=none; b=N/eu9PcZTfxF+z7+oTMJ8zbCLSlYNVWf7jrIBOuC/XLHs577UJvuvHXB3rdqjrKKaG+jtNCwcGNqH3W5xg+2USRLctgVhEzFd6qNUjhLQzw7V5Lg4thfDc5cFaPhDrVYNI9fpXMvASPRVfzhSPXHcvVkOgpl8z+Hq9v3iF1ebUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177525; c=relaxed/simple;
	bh=JsPo+YU0MuEfP3CdDiarzkzLbbh+DS3W3mn9L4o0Mws=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E4XvVYC1RCXW6+sjl13CEXQSEdxlhafOLf5lGi4rq26YCWGUHFd017YY6gmBpMj2QlP7IXLcT2XDbZJS67lyPhL7X6gue4Ue+GSIjHHtAVeETwA9MkTFsCS7sD1tx/FsnsAZhe+U4HBj26R2yaNPG6QYmFkhDHXXOqcL6Poo4cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dU1NV+fg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dU1NV+fg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6911F00893;
	Wed, 23 Sep 2026 15:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177518;
	bh=WC1P3wTXESA6BgqvPPiBmdyDCM54RO/X3Gr7C82V1sQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dU1NV+fgr3k1lggAXGPqTBUYmrZiYmi7lzDqkzEWCcdWleAZNy9IJOieScVK5YPrz
	 +uf9F4bIxA+IIHiI49WWYGoL6/UMsNnd0uwcXqQRUoKcCtIh/L2mkwta/6xMukjJ8R
	 ekd55pEWdgkg3VCWcl28pAzPcqGegzwIkSJzMKfPjiW5B+Tb+/DeZwGYMazjblPUA+
	 gIHve/UaNYA/a5BIAXrZRzX1JEnaSkucn7XK/gSoxWJDmf5i7Qyts0Wr2bRS4LiZzf
	 lzm24AsUIjNzKQQRJCEwcAeLDGGSG+8lKK/r3Kx5JUr21mZL9zVaPd6q3+0oGGavR5
	 i6X7VokIBU58A==
Subject: Re: [PATCH] phonet: pep: fix out-of-bounds reads in
 pep_ctrlreq_error() and pep_sock_accept()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: courmisch@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 15:31:57 +0000
Message-ID: <179017751768.2160803.16464935071666517964@kernel.org>
In-Reply-To: <20260919212852.3240704-1-benquike@gmail.com>
References: <20260919212852.3240704-1-benquike@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0 (5)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch bundles three logically independent changes into one
  commit: (a) the 1-byte OOB-read hardening in pep_ctrlreq_error() /…
- [Medium] The changelog misidentifies the out-of-bounds read it fixes.

Pre-existing issues:
- [Low] In-tree sender and receiver of PNS_PEP_CONNECT_REQ disagree on
  the 4-byte payload layout that follows the pnpipehdr.
- [Low] The file-level locking-policy comment for struct pep_sock in
  net/phonet/pep.c (lines 33-37: 'pep_sock locking: - sk_state, hlist:…
- [Low] Documentation/networking/phonet.rst describes PNPIPE_HANDLE as 'a
  read-only integer value', but pep_setsockopt() accepts it: when…
- [Low] Documentation/networking/phonet.rst states 'The pipe protocol
  provides two socket options at the SOL_PNPIPE level' and then…
- [Low] The new writer-side locking in pep_setsockopt() does not remove
  the data race on pn->ifindex with getsockopt readers:…

--

phonet: pep: fix out-of-bounds reads in pep_ctrlreq_error() and pep_sock_accept()

This adds pskb_may_pull() coverage for the control-request path in
pep_ctrlreq_error() and pipe_do_rcv(), adds the missing __skb_pull() plus a
length check before the sub-block loop in pep_sock_accept(), and re-acquires
the socket lock around the pn->ifindex assignment in the PNPIPE_ENCAP case of
pep_setsockopt().  No Link: tags are present in the commit header.

A few questions below.

> diff --git a/net/phonet/pep.c b/net/phonet/pep.c
> index bd1cdd00edfa..5511770bb21c 100644
> --- a/net/phonet/pep.c
> +++ b/net/phonet/pep.c
> @@ -192,15 +192,21 @@ static int pep_reject_conn(struct sock *sk, struct sk_buff *skb, u8 code,
>  static int pep_ctrlreq_error(struct sock *sk, struct sk_buff *oskb, u8 code,
>  				gfp_t priority)
>  {
> -	const struct pnpipehdr *oph = pnp_hdr(oskb);
> +	const struct pnpipehdr *oph;
>  	struct sk_buff *skb;
>  	struct pnpipehdr *ph;
>  	struct sockaddr_pn dst;
> -	u8 data[4] = {
> -		oph->pep_type, /* PEP type */
> -		code, /* error code, at an unusual offset */
> -		PAD, PAD,
> -	};
> +	u8 data[4];
> +
> +	oph = pnp_hdr(oskb);
> +	if (!pskb_may_pull(oskb, (unsigned int)((oph->data + 1) - oskb->data)))
> +		return -EINVAL;
> +
> +	oph = pnp_hdr(oskb);
> +	data[0] = oph->pep_type; /* PEP type */
> +	data[1] = code; /* error code, at an unusual offset */
> +	data[2] = PAD;
> +	data[3] = PAD;

[Severity: Medium]
The new check looks correct, but does the changelog name the wrong read?  It
says:

   1. In `pep_ctrlreq_error()`, `oph = pnp_hdr(oskb)` is dereferenced at
      `oph->pep_type` (`oph->data[0]`, offset 4 from `pnp_hdr(oskb)`)

struct pnpipehdr in include/net/phonet/pep.h is made only of u8 members:

struct pnpipehdr {
	u8			utid;
	u8			message_id;
	u8			pipe_handle;
	union {
		u8		state_after_connect;
		...
		u8		pep_type;
		u8		data0;
	};
	u8			data[];
};

So pep_type is at offset 3, data[] begins at offset 4 and sizeof(*hdr) is 4.
The caller pep_do_rcv() already guarantees those four bytes:

	if (!pskb_may_pull(skb, sizeof(*hdr)))
		goto drop;

which means oph->pep_type was in bounds.  The read that was not covered is
the later one in the same function:

	ph->data0 = oph->data[0]; /* CTRL id */

That touches offset 4 and needs five linear bytes, which is exactly what the
new pskb_may_pull(oskb, (oph->data + 1) - oskb->data) provides.  Could the
changelog point at oph->data[0] instead of oph->pep_type, so a reader
checking the named expression does not conclude there is nothing to fix?

>  
>  	skb = pep_alloc_skb(sk, data, 4, priority);
>  	if (!skb)

[ ... ]

> @@ -823,6 +831,7 @@ static struct sock *pep_sock_accept(struct sock *sk,
>  
>  	/* Parse sub-blocks (options) */
>  	n_sb = hdr->data[3];
> +	__skb_pull(skb, sizeof(*hdr) + 4);

[Severity: Low]
This isn't a bug introduced by this patch, but the new __skb_pull() fixes the
sub-block offset according to the receiver's reading of the message, and the
in-tree sender disagrees with it.  pep_sock_connect() builds the connect
request payload as:

	u8 data[4] = { 0 /* sub-blocks */, PAD, PAD, PAD };

so the sub-block count goes at data[0] (header offset 4), while
pep_sock_accept() decodes peer_type from hdr->other_pep_type (also data[0])
and the count from hdr->data[3] (offset 7).

The connect-response pair is self-consistent: pep_accept_conn() emits
PAD, PAD, PAD, 2 and pep_connresp_rcv() reads hdr->data[3].

Nothing misbehaves today since the kernel always announces zero sub-blocks
and PAD is zero.  Is the request sender's layout worth a separate fix?

>  	while (n_sb > 0) {
>  		u8 type, buf[1], len = sizeof(buf);
>  		const u8 *data = pep_get_sb(skb, &type, &len, buf);

[ ... ]

> @@ -1048,8 +1059,16 @@ static int pep_setsockopt(struct sock *sk, int level, int optname,
>  			release_sock(sk);
>  			err = gprs_attach(sk);
>  			if (err > 0) {
> -				pn->ifindex = err;
> -				err = 0;
> +				lock_sock(sk);
> +				if (sock_flag(sk, SOCK_DEAD) || pn->ifindex) {
> +					release_sock(sk);
> +					gprs_detach(sk);
> +					err = -EINVAL;
> +				} else {

[Severity: Medium]
Item 3 of the changelog states:

   3. In `pep_setsockopt()` (`PNPIPE_ENCAP`), `release_sock(sk)` is dropped
      around `gprs_attach(sk)`, and `pn->ifindex` is assigned afterwards
      without re-acquiring `lock_sock(sk)`

The release_sock(sk) ahead of gprs_attach() is already present in the
baseline and this diff keeps it unchanged; only the lock_sock()
re-acquisition and the SOCK_DEAD / pn->ifindex recheck are new.  Could that
sentence be reworded?

Separately, this hunk changes what userspace sees: a
setsockopt(SOL_PNPIPE, PNPIPE_ENCAP, PNPIPE_ENCAP_IP) that previously
returned 0 can now return -EINVAL and, via gprs_detach(), unregister the
gprs netdev that gprs_attach() just created and drop the socket reference.

That is unrelated to the parsing changes in pep_ctrlreq_error() /
pipe_do_rcv() and in pep_sock_accept(), and all three share one Fixes: tag.
Would splitting this into one logical change per patch make the parsing
fixes easier to pick up for stable?

> +					pn->ifindex = err;
> +					err = 0;
> +					release_sock(sk);
> +				}

[Severity: Low]
This is a pre-existing issue and not introduced by this patch, but the store
to pn->ifindex is now marked while the readers still are not.
do_pep_getsockopt() reads it for two options:

	case PNPIPE_ENCAP:
		val = pn->ifindex ? PNPIPE_ENCAP_IP : PNPIPE_ENCAP_NONE;
		break;

	case PNPIPE_IFINDEX:
		val = pn->ifindex;
		break;

and neither pep_getsockopt() nor sock_common_getsockopt() takes the socket
lock on the way in, so KCSAN can still flag the pair.  Would converting
these accesses to READ_ONCE()/WRITE_ONCE() while here be reasonable?

>  			}
>  		} else {
>  			pn->ifindex = 0;

Two further notes that need no diff context:

[Severity: Low]
This is a pre-existing gap rather than something this patch introduced, but
the pep_sock locking policy comment near the top of net/phonet/pep.c reads:

 * pep_sock locking:
 *  - sk_state, hlist: sock lock needed
 *  - listener: read only
 *  - pipe_handle: read only

ifindex is not listed there, even though the fix in pep_setsockopt() relies
on it being read and written under lock_sock().  Could a line for ifindex be
added while touching this?

[Severity: Low]
This is pre-existing and untouched by the patch, but
Documentation/networking/phonet.rst describes PNPIPE_HANDLE as "is a
read-only integer value", while pep_setsockopt() accepts it:

	case PNPIPE_HANDLE:
		if ((sk->sk_state == TCP_CLOSE) &&
			(val >= 0) && (val < PN_PIPE_INVALID_HANDLE))
			pn->pipe_handle = val;

Should the documentation say it is writable while the socket is closed?

[Severity: Low]
Also pre-existing and not caused by this patch: the same file says "The pipe
protocol provides two socket options at the SOL_PNPIPE level" and then
documents three of them (PNPIPE_ENCAP, PNPIPE_IFINDEX, PNPIPE_HANDLE).
PNPIPE_INITSTATE is exported by include/uapi/linux/phonet.h and handled by
both pep_setsockopt() and do_pep_getsockopt(), but is not documented.  Could
the count and the missing option be fixed up?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919212852.3240704-1-benquike%40gmail.com
