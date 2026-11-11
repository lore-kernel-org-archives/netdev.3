Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425101;
	b=Y9psRFO8tqWWXTX43g0nHZM69nxnh6/awiaxBA1XqQ2X5NAo4dReVvEwA1Ix1MuaE9Zw
	 uaOLeA739b4JSnPMpF4GKrBOJvRNhTwuy905+lVF213ki5U9A6iBImbzG2EImUNWfNsKO
	 1Kswiug8YO6elgufyScABRf+Kisj5TaEHXNyjzX7IoBB9xkpmG72jLVM8YdGLUu0Z/mgi
	 n0xoAVrOftY1xlqrooxo1/hEcNb2YYC3x8YlFUQWKVH+tZIgRl4C5DwCiMXiiy1ZIsYQ4
	 jg5D0E+z2Cv4094p4lfaG8lqpv50lexyjpAyPWUTuNN5G6vlAJSwjl3lVRv9cs0RohA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425101;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6UbhasV7MgH1+H5s5GgeNx3/kPkJyVxkDdLk3Ej1BsM=;
	b=NpD+1g3vmeZNPj8iGZoPgeEYH8gyc70qTldU2dJfxTVip+J6lhdpCLEa9GNGaraOGGyN
	 88inqexOULyHCGeUlzfRMxRm1gi2V2EL8UfmD3zl7JoiJrhNcb5XIsXIfPDChNqRhzUvQ
	 NxI/M4T/+WqdSONLCWjPtW+e1H0/UY5ue8iOUmjhUzNI5cpWftfqRWfGT+wRBr5zqF94D
	 x8nbBUkln1DovQ042IeNQZK4L4YU+oRkRYu8JWGXLrPzOXZ7RhErMLC4j9mPzzsxMgO6A
	 TOuEHod+/179JDlc50XVHQWCeP001mNj7W/N9d+FZTDWVepboKfs2hBN1P43Ziijw9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNi+2f2y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C98606A339
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNi+2f2y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DE41F00A05;
	Wed, 11 Nov 2026 19:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425100;
	bh=6UbhasV7MgH1+H5s5GgeNx3/kPkJyVxkDdLk3Ej1BsM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KNi+2f2yFKYqGyBVbRa8dDNSlF+mNLnEu0V3sgEqDPqx7YajwUtLosidL875F2P4F
	 FsAWItV/B9VBqP7v1iB7AcE88UHAjzOFv6ytgodU/qfbJire2P3mO78w64jBe3jiqv
	 E4Yj0WD8L85NcgSpgQv4F+FQJUPnOP6c6/2hOULk762eiB7hWniNE3sTR85oGFiW8l
	 cQ/88+4B/V0gZ/yaEDEkrTNVali8qUiYV65xzwDKTNHbCEwFIT5igxqrK+v/5ZMP+k
	 Y9EQX2WGcNoiUbssvxupODAblpI5NdAH6gMXVcW89vVjizDkL13jGywGOl/c5Gl9g7
	 /R9ScsGz+Jn3Q==
Subject:
 Re: [PATCH net] vxlan: annotate lockless accesses to rdst->remote_ifindex
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
Date: Wed, 11 Nov 2026 19:24:59 +0000
Message-ID: <179442509959.2199510.3903700917435793719@kernel.org>
In-Reply-To: <20261110072208.3273638-1-edumazet@kernel.org>
References: <20261110072208.3273638-1-edumazet@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Rolling back a failed FDB replace still writes
  rdst->remote_ifindex with a plain store, so the patch misses one of…

--

vxlan: annotate lockless accesses to rdst->remote_ifindex

The patch adds READ_ONCE() to the lockless RCU readers of
rdst->remote_ifindex in vxlan_fdb_info(),
vxlan_fdb_switchdev_notifier_info(), vxlan_snoop() and vxlan_xmit_one().
It also changes the in-place update in vxlan_fdb_replace() to use
WRITE_ONCE().

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index d11028b374721..13bfb1bb11b7b 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c

[ ... ]

> @@ -569,7 +572,7 @@ static int vxlan_fdb_replace(struct vxlan_fdb *f,
>  	rd->remote_ip = *ip;
>  	rd->remote_port = port;
>  	rd->remote_vni = vni;
> -	rd->remote_ifindex = ifindex;
> +	WRITE_ONCE(rd->remote_ifindex, ifindex);
>  	rd->offloaded = false;
>  	return 1;
>  }

[Severity: High]
This annotates the forward write in vxlan_fdb_replace(). Is the rollback
of the same write in vxlan_fdb_update_existing() still a plain store?

drivers/net/vxlan/vxlan_core.c:vxlan_fdb_update_existing() {
    ...
		err = vxlan_fdb_notify(vxlan, f, rd, RTM_NEWNEIGH,
				       swdev_notify, extack);
		if (err)
			goto err_notify;
    ...
err_notify:
	if (nhid)
		return err;
	if ((flags & NLM_F_REPLACE) && rc)
		*rd = oldrd;
    ...
}

When vxlan_fdb_notify() fails after vxlan_fdb_replace() has run, the
struct copy rewrites rd->remote_ifindex on an rdst that is still linked
on f->remotes. Only vxlan->hash_lock is held. vxlan_xmit_one(),
vxlan_snoop() and the RCU dump paths can be reading the field with the
new READ_ONCE() at the same time.

This path can be reached in tree. mlxsw_sp_switchdev_vxlan_work_prepare()
returns -EOPNOTSUPP for a non-zero remote_ifindex ("Local interface is
not supported"), a non-default port or VNI, or a multicast destination.
It also fails if its GFP_ATOMIC allocation fails. The result is
NOTIFY_BAD, and vxlan_fdb_notify() then returns an error. So a
"bridge fdb replace ... via <dev>" on an mlxsw-offloaded VXLAN goes
through WRITE_ONCE() and then a plain-store restore while traffic is
flowing.

Would it make sense to restore the fields one at a time in err_notify,
using WRITE_ONCE(rd->remote_ifindex, oldrd.remote_ifindex)?

A related point about the same struct copy: it also copies the old
rd->dst_cache back, including reset_ts from before the
dst_cache_reset() in vxlan_fdb_replace(). Could a dst that TX cached
for the rejected destination during that window count as valid again
once the old destination is restored? Calling dst_cache_reset() again
in the rollback, instead of copying dst_cache back, would avoid that.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110072208.3273638-1-edumazet%40kernel.org
