Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3D8283C89
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055020; cv=none; b=eRjwwDuGYb9SnXaPisMYeOJb/cbSk5DlNgztbvZcWX1qliu9JoueikQscybdZA3UrfqCzQINkaLMSUgLPTVzNZ7msVoZd5xmPP1GHo938VX7kDnhAAdkKXsGLHDdinqQy1dhFPVAnMa/T7qita34AxBv/xwUlAJ75C+pauryMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055020; c=relaxed/simple;
	bh=Yu50h+5KdmI5E+k25xvnfbBwM19gr/sgCj1mpwTTwKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaX4jGw4zuv4bGfQCYAz3cuPRkJtk2cCl55XXlxZUhKlQrEJ3lEkLvjl+6T7UbC1ayEsTHiMPzr5+8njuuou+7LUCSNwbEcfqtryhpfkjAlPlKyedFy2rTIoPkuydVo6osf6ryIgHKSlUZ7grltbKVW3h8qcjHOXt1kSIVHUPXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDv9bjH3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDv9bjH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0251F00893;
	Wed, 10 Jun 2026 01:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781055019;
	bh=vnjj5xwzvzivpvmbEwsldfdmWzi3yTibzkYnST9A/1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dDv9bjH30iEpFXGPyItMaoK97lwtTNs9JubunePeRNqYUD5ibX/f0ZMsv/vMfEsIh
	 0IvTAOJOQN93UWyU+jckLzt9y88iUVVBB8VRm9ur5YheC7BHKwki7F7r1ZuMIdyuGd
	 wH8g1zJUJzNXyXa88sY/Ny+ohiHWmp1/Ms5YPhCjRyWFjKm+slTe1+Ovj6eKb6o5cK
	 dxbRdciVXS4m9Bjn28Qb7Q+TtRBQ9N9g8Lxf8BHlTWfsR0fayVMMBLVlIvazfUK647
	 C0p4n7EhNzG+Obhsg7HJJRyqOOTM6EPJEkWkcfYmMZQzBgh3JVVuk3/IY9qAp+ivb2
	 5VBVeHqu2EYtA==
Date: Tue, 9 Jun 2026 18:30:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, davem@davemloft.net, yotam.gi@gmail.com,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bestswngs@gmail.com
Subject: Re: [PATCH net] psample: zero the netlink attribute padding in
 PSAMPLE_ATTR_DATA
Message-ID: <20260609183018.1764046d@kernel.org>
In-Reply-To: <20260607031640.2743713-1-xmei5@asu.edu>
References: <20260607031640.2743713-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jun 2026 20:16:40 -0700 Xiang Mei wrote:
> psample_sample_packet() open-codes the PSAMPLE_ATTR_DATA attribute.
> It reserves nla_total_size(data_len) bytes via skb_put() but only writes
> NLA_HDRLEN + data_len of them, so when data_len is not a multiple of 4 the
> up to 3 trailing alignment-padding bytes are left uninitialised.  The skb
> head comes from kmalloc_reserve(), which does not zero memory, so those
> bytes hold stale slab contents that are then broadcast to all listeners on
> the PSAMPLE_NL_MCGRP_SAMPLE multicast group, leaking kernel heap memory to
> userspace.
> 
> Zero the trailing padding after the payload copy.
> 
> Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for packet sampling")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/psample/psample.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index 7763662036fb..26220dca0f12 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -485,6 +485,9 @@ void psample_sample_packet(struct psample_group *group,
>  
>  		if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
>  			goto error;
> +
> +		memset((unsigned char *)nla + nla->nla_len, 0,
> +		       nla_padlen(data_len));
>  	}
>  
>  #ifdef CONFIG_INET

Could you see if this diff works? I think it's slightly cleaner:


 diff --git a/net/psample/psample.c b/net/psample/psample.c
index 7763662036fb..c112e1f0ccac 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -476,15 +476,17 @@ void psample_sample_packet(struct psample_group *group,
                goto error;
 
        if (data_len) {
-               int nla_len = nla_total_size(data_len);
+               int nla_len = nla_attr_size(data_len);
                struct nlattr *nla;
 
                nla = skb_put(nl_skb, nla_len);
                nla->nla_type = PSAMPLE_ATTR_DATA;
-               nla->nla_len = nla_attr_size(data_len);
+               nla->nla_len = nla_len;
 
                if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
                        goto error;
+
+               skb_put_zero(nl_skb, nla_padlen(data_len));
        }

 #ifdef CONFIG_INET
