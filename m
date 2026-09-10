Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5ED30DEDC;
	Thu, 10 Sep 2026 03:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789012269; cv=none; b=S/0RJG+IqKkZBloNKgaffwlKXDUWW+R9JVYDawEuIY0Y6RaykQrtJmthE0/4KmgUyOUG5MDMiqOzDomz1I2vZ2yPS2V1Zw4soODT/9S+4PEfllD5JhSb++6SyDdPMNlCQm+zwIk3QUfw0TZO1x23Nnx++zaHTxTGlUI1XYZEa9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789012269; c=relaxed/simple;
	bh=zbufan/RqJ5Q1nBrrI4Svq41WAkcjTFrNniJSes07uU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=em9Sgk8N5c+UtUSG/t2nhvv6jfQxF8kqr2DEdOD4P9pAYCvdndkRIFva6DtoozdT2xsNGd5qEdhDQoZimvu+wSAby/+2o8AAiE8Jcnn77jLHsql0bdJlKo5cq+c/6r3PZVib9MBXYZhmlSPKesuNb4tSi0DNMpKC4fylNUH8zpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPIOfPW0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPIOfPW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7036D1F000FF;
	Thu, 10 Sep 2026 03:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789012268;
	bh=0mtID7B/XCQ+V2hgeDztPVv74Rf9vBOfMI+kn5Mh+II=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LPIOfPW0PSyuN3UYrFaddmVfLevOLY5Nh1KUk9QWg5xaJHNhs9FkqV4bE98ZhN0Ak
	 zsNDoOEQ349zitkOIS7SRlxUNu/Hs8Wavu/yX2muzVopVRiU5Cn2PyLHAhlEaurpuq
	 J49KWSWxCZSPRyHFCmkosZQ4rkErGlU25GVPXgcflUXvF9FTq9A1inPxGZEUK7hNh6
	 KaYUIH2T1reiqMc8loCSglI8BbJmkAnlJQAyGvBg9lniybJU996TVQMP72Eez3zFwK
	 NRgeoNb5DRAF5NisnSj+FXAFqqyRV5a5FgJ9pmje9RGPQBtutElPBBxp+LOGRaGFZT
	 gXQ7vILpadQFw==
Subject: Re: [PATCH net v2] nfc: llcp: fix slab-out-of-bounds read in
 nfc_llcp_wks_sap()
From: netdev-bot+sashiko@kernel.org
To: omermetekaya0@gmail.com
Cc: netdev@vger.kernel.org, david@ixit.cz, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+1e3df0852e82c21ca418@syzkaller.appspotmail.com
Date: Thu, 10 Sep 2026 03:51:06 +0000
Message-ID: <178901226692.219967.13793449876885823121@kernel.org>
In-Reply-To: <20260905225211.596366-1-omermetekaya0@gmail.com>
References: <20260905225211.596366-1-omermetekaya0@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0 (1)

- [Medium] Missing `Fixes:` tag on a [PATCH net] bug fix.

Pre-existing issues:
- [Medium] Prefix-match logic error in nfc_llcp_wks_sap()
  (net/nfc/llcp_core.c:351-357): the loop does `strncmp(wks[sap],…
- [Low] Unfixed sibling of the same defect class:
  nfc_llcp_build_sdreq_tlv() (net/nfc/llcp_commands.c:138) still does…

--

nfc: llcp: fix slab-out-of-bounds read in nfc_llcp_wks_sap()

This changes the pr_debug() in nfc_llcp_wks_sap() from %s to %.*s bounded
by service_name_len, so the non-NUL-terminated kmemdup()'d service name
copied in llcp_sock_bind() is no longer over-read by the printk format
scan.

Closes: https://syzkaller.appspot.com/bug?extid=1e3df0852e82c21ca418

> v2: Changed prefix to [PATCH net] but still I could not find the Fixes: tag both in the gitblame and the lore.

[Severity: Medium]
Regarding "still I could not find the Fixes: tag both in the gitblame and
the lore" - does git blame on the removed statement point at the original
LLCP support commit?

Blaming the pr_debug("%s\n", service_name); line in nfc_llcp_wks_sap() at
the baseline attributes it to:

  d646960f7986 ("NFC: Initial LLCP support")

Only the enclosing function signature was touched later, by 3df40eb3a2ea.
The unterminated kmemdup() of the user-supplied service name in
llcp_sock_bind() / llcp_sock_connect() comes from the same initial LLCP
series, so would:

  Fixes: d646960f7986 ("NFC: Initial LLCP support")

be the right tag here?  Without it the affected range (everything since
v3.3) has to be worked out by hand for stable backports, and the net tree
process asks for the tag on fixes.

> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index cac1b5487064d..fda236e4d9fdc 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -341,7 +341,7 @@ static int nfc_llcp_wks_sap(const char *service_name, size_t service_name_len)
>  {
>  	int sap, num_wks;
>  
> -	pr_debug("%s\n", service_name);
> +	pr_debug("%.*s\n", (int)service_name_len, service_name);

[Severity: Low]
This is a pre-existing issue and not introduced by this patch, but is
there a second copy of the same pattern that could be converted in the
same change?  nfc_llcp_build_sdreq_tlv() in net/nfc/llcp_commands.c does:

  pr_debug("uri: %s, len: %zu\n", uri, uri_len);

The uri here is nla_data() of NFC_SDP_ATTR_URI, passed in from
nfc_genl_llc_sdreq() together with nla_len().  The policy entry is:

  [NFC_SDP_ATTR_URI] = { .type = NLA_STRING,
                         .len = U8_MAX - 4 },

NLA_STRING only trims an optional trailing NUL, it does not require one,
and the rest of nfc_llcp_build_sdreq_tlv() is written length-based
(if (uri[uri_len - 1] == 0) sdreq->tlv_len--; and memcpy(sdreq->uri, uri,
uri_len)), so no terminator is assumed there either.

Note this one does not appear to be able to produce the KASAN report the
changelog quotes: the payload sits in the netlink skb linear area and the
format scan stops on a zero byte inside the zeroed skb_shared_info of the
same allocation:

  net/core/skbuff.c:__alloc_skb() {
      ...
      memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
      ...
  }

What is left is the unbounded %s printing adjacent attribute bytes plus up
to three bytes of uninitialised SKB_DATA_ALIGN padding into dmesg, and it
needs CAP_NET_ADMIN (NFC_CMD_LLC_SDREQ carries GENL_ADMIN_PERM) plus an
enabled dyndbg callsite.  Would

  pr_debug("uri: %.*s, len: %zu\n", (int)uri_len, uri, uri_len);

be worth folding in for consistency?  The other %s users of a URI look
fine, since sdreq->uri points into a kzalloc(sdreq->tlv_len + 1).

>  
>  	if (service_name == NULL)
>  		return -EINVAL;
>  

The unquoted remainder of nfc_llcp_wks_sap() is the comparison loop:

  net/nfc/llcp_core.c:nfc_llcp_wks_sap() {
      ...
      for (sap = 0; sap < num_wks; sap++) {
              if (wks[sap] == NULL)
                      continue;

              if (strncmp(wks[sap], service_name, service_name_len) == 0)
                      return sap;
      }
      ...
  }

[Severity: Medium]
This is a pre-existing issue that the patch does not introduce, but since
the change lands two lines above it: should this comparison also require
service_name_len == strlen(wks[sap])?

As written, any strict prefix of a well-known name matches, for example
strncmp("urn:nfc:sn:ip", "urn:nfc:sn:i", 12) == 0 returns sap 2, and even a
single byte "u" matches.

nfc_llcp_wks_sap() is only reached from nfc_llcp_get_sdp_ssap(), which
passes the name and length verbatim from llcp_sock_bind() and
llcp_sock_connect().  Both just kmemdup() the user-supplied name under
min_t(..., NFC_LLCP_MAX_SERVICE_NAME) with no content validation, and
nfc_sock_create() does no capability check.

nfc_llcp_get_sdp_ssap() then treats the socket as the well-known service:

  net/nfc/llcp_core.c:nfc_llcp_get_sdp_ssap() {
      ...
      if (test_bit(ssap, &local->local_wks)) { ... return LLCP_SAP_MAX; }
      set_bit(ssap, &local->local_wks);
      return ssap;
      ...
  }

So a bind of "urn:nfc:sn:i" reserves the SAP belonging to
"urn:nfc:sn:ip", advertises it to the peer in the LLCP WKS general bytes,
and a later bind of the real name then fails with -EADDRINUSE.

The two peer-side sites in the same file do enforce exact length,
nfc_llcp_recv_snl() with:

  if (service_name_len == strlen("urn:nfc:sn:sdp") &&
      !strncmp(service_name, "urn:nfc:sn:sdp", service_name_len)) {

and nfc_llcp_sock_from_sn() skipping candidates whose service_name_len
differs before memcmp().  Is the missing length equality check here just an
oversight?  No out-of-bounds access is involved, strncmp reads at most
service_name_len bytes.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260905225211.596366-1-omermetekaya0%40gmail.com
