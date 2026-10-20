Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527883;
	b=2NQe3CuAmb5REONC6RJAdxVQGifS1t+Ka9c7aEMk2cKZ/GljwzkqfxWCpqUUzVCSY95B
	 7DBpqOmsiI+8cUI/UwwAjl/yb/nuwbaetPCZSDgGGtjHwVOq6u+4VkEcDC9ZZvt8920zQ
	 85SJQ73WTcDLrpLWvAHZxv1g+DMDiKtoxDd/oemDlxovYM24S2czBAe2nGRXfbRctbXQF
	 W4eEXf9pcYerzgo2SjOFgmn/QvqZhGQ+plMSJWvmTqTcKagjufMs5pGTa+y0kjqmWq7Ho
	 lAIErqWx0+0hlihGQlj6GDXOlubne4rQVIB8SAwV+t3q1Ad92EhlZUUfRp/F9mwjI8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527883;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+uAvWuSQaoAF+FL2ygKeLUjGdfuQVNcj/nsVPiMmrTg=;
	b=B2mNKegKkNU2H7l9i/ohv65/9f87uZk1Mw/8ZRkvd5BPEiE9FSFYey6HRzorvfK9tbK8
	 20OsupBc41413tNMCL5rsa5jCnHoe/plPWdYW4q0dSN03gvKLk8KurjABX9+0sTCI4Jb+
	 gzzX8hFoPs63adtNa4mNHKZqOFIvRzb2hpaa1QJHeo3Gouko6NOY9ZWriyiMyBWEfFH6g
	 N7f481lyFhoXLYt91qVGb5fHBmo4EStMSSbWcNt1v6Ifvw8cSxgCuoB8/u+lUIecq1lCS
	 eCppnfBKvHP0uLet9C+gdi4X/9ea2j0DpTPaPbELNrb2JIKfbeq/+I6VvSWxyBbEzkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evojr3Nr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA171606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evojr3Nr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221D91F000C9;
	Tue, 20 Oct 2026 20:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792527882;
	bh=+uAvWuSQaoAF+FL2ygKeLUjGdfuQVNcj/nsVPiMmrTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=evojr3NrU7BPrLWqGboCXuHjN5MWWl5YmljM6A1qR+bCLN0bAd1DNQQrRej6Mf4v5
	 TXA/egKLLigYZuu9UiQPyv3zIK1lrcD5TtxaOi0YftCGBXAmUksO77zJcnbqttiv08
	 tN8o+Pr/N4nC0iq0d89scdLfz9u1H/7dwxHqx3YgI+CxKnhT/r4es/AEpeg5sRXo1f
	 oMogsYLcCE+TylLUS0nelA0QYC0QliBxPVbtXCIvTIrS1JEHgEikvxWXEnP/CIYKZ0
	 P8lFFW1YUjJ6vxNadD3fhk7OsgA/Nhpb5gXNeGjL5aYvBNVqHouC8TDoolDVSyqe9w
	 vVBb+srTOT3tg==
From: Jakub Kicinski <kuba@kernel.org>
To: houminxi@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [PATCH net-next v3 1/2] netlink: specs: add ovs_flow del and set operations
Date: Tue, 20 Oct 2026 13:24:40 -0700
Message-ID: <20261020202440.1012706-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015024132.698658-2-houminxi@gmail.com>
References: <20261015024132.698658-2-houminxi@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
netlink: specs: add ovs_flow del and set operations

This patch adds the del and set operations to the ovs_flow YNL spec. It
marks new, del and set as needing admin permission and lists the
attributes each command reads. It also changes probe from binary to flag
to match the kernel policy, and rewrites the doc for the key attribute.

> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
> index 951837b72e1d..e5e110b6ccc8 100644
> --- a/Documentation/netlink/specs/ovs_flow.yaml
> +++ b/Documentation/netlink/specs/ovs_flow.yaml
> @@ -384,7 +384,9 @@ attribute-sets:
>          nested-attributes: key-attrs
>          doc: |
>            Nested attributes specifying the flow key. Always present in
> -          notifications. Required for all requests (except dumps).
> +          notifications. A request may carry a ufid instead, except for a
> +          new flow, which needs a key. A set that replaces the actions
> +          needs a key too.

[Severity: Low]
Should include/uapi/linux/openvswitch.h get the same update? The
kernel-doc for enum ovs_flow_attr still says:

 * @OVS_FLOW_ATTR_KEY: Nested %OVS_KEY_ATTR_* attributes specifying the flow
 * key.  Always present in notifications.  Required for all requests (except
 * dumps).

The spec text was first copied from that header. After this patch the two
in-tree descriptions of this attribute disagree, and the header still
describes a rule the kernel does not enforce.

ovs_flow_cmd_set() only rejects the request when both the key and the ufid
are missing:

	if (!a[OVS_FLOW_ATTR_KEY] && !ufid_present) {
		OVS_NLERR(log,
			  "Flow set message rejected, Key attribute missing.");
		return -EINVAL;
	}

ovs_flow_cmd_get() does the same:

	} else if (!ufid_present) {
		OVS_NLERR(log,
			  "Flow get message rejected, Key attribute missing.");
		err = -EINVAL;
	}

The new wording also drops the "except dumps" exception. "A request may
carry a ufid instead" suggests that every request other than new needs
either a key or a ufid. But ovs_flow_cmd_dump() reads neither, and a del
that carries neither is a valid flush of the data path.

Could the doc mention those two cases as well?

[Severity: Low]
This is a pre-existing issue, not one this patch introduced, but is
"Always present in notifications" accurate? This patch keeps the sentence
in the paragraph it rewrites, and the same text is in
include/uapi/linux/openvswitch.h.

ovs_flow_cmd_fill_info() calls ovs_nla_put_identifier(). For a
ufid-identified flow, that emits OVS_FLOW_ATTR_UFID instead of the key:

	if (ovs_identifier_is_ufid(&flow->id))
		return nla_put(skb, OVS_FLOW_ATTR_UFID, flow->id.ufid_len,
			       flow->id.ufid);

The key is then added only if should_fill_key() returns true:

	return ovs_identifier_is_ufid(sfid) &&
	       !(ufid_flags & OVS_UFID_F_OMIT_KEY);

So when the flow is ufid-identified and the request sets
OVS_UFID_F_OMIT_KEY in ufid-flags, the reply or notification has no key.

[ ... ]

> @@ -438,7 +440,7 @@ attribute-sets:
>            are exact match bits.
>        -
>          name: probe
> -        type: binary
> +        type: flag

[Severity: Low]
This corrects an existing mismatch with the kernel policy in flow_policy:

	[OVS_FLOW_ATTR_PROBE] = { .type = NLA_FLAG },

The binary type came in with the commit that added ovs_flow.yaml. Should
this change carry a tag like:

Fixes: 93b230b549bc ("netlink: specs: add ynl spec for ovs_flow")

Could it also go in a separate patch, so it can be picked up or backported
apart from the new del and set operations?

>          doc: |
>            Flow operation is a feature probe, error logging should be suppressed.

[ ... ]
-- 
pw-bot: cr
