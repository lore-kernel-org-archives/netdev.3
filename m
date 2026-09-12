Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE72DECC2
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789198813; cv=pass; b=fdI13mmuVjo0xEXSGjEMmYieS95QVJ9/QpfQxh4GlLL6d8M8BNhhlbLYjQyY3nq/w09868BcVoJmwt3OdEUg0q5VH+QRlZxc+G3REL0MHgdGxeY1StLRdc9FnO104ceKc8UZzRxWM3WgMQaaHZcS7SSmXuVE4FYou85qgkMOts0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789198813; c=relaxed/simple;
	bh=a5BgZIa2nN3V7GG8MnhDOEO9Xluz3rwKpxUKZrZY1y0=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=M8i+2p7S/PTO2pRStH6wSFlfC+bOf9Uh25UNZhZShMxLO6+e78G/5o9UjK0QjhYRtDtGyUGOGnkSVyh2efcwWFTYGjXA0vKpJgdIpAUg/SKUtDasMN1x0qoJ3Z8Rz+IhVgmk1VXv2u/A0zXoS0M/zx8wj7lkmqrO4uTwOh4RzFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=OMN+nqkl; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="OMN+nqkl"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-86b90133ae8so498357b3a.1
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:40:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789198811; cv=none;
        d=google.com; s=arc-20260327;
        b=Rg0GNgC8HKXU+o09zOEMeGwtgcy19aUyLA7e75nHqMSxdTq/DhHshz0KWbhBr/78Ak
         g6mkxwYOERb29cNbC6tomkZUWn2yLDAJMtsv1O/W4HpI4+6RkHLnoWoBQZkQNBzaDcTf
         R0X6P5sUKNRvWlR8dF9V/4V2VsV3a15WMbrJH1NBcdtB+UXAB8GwTfbot8SVLKpAgW69
         Ha6O038nEB9MFUqIO1PaaXBJL2hf/0Nn2uMAyy1w5Oolma2/sWAKWhooILxlkLr70SuP
         rsnm3fnUDUVulBMuDYdyAiWzelEjy+PRKeqArGDk8XjZUKd6IaDk0jWQ2MdzctMe5VEE
         rgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=QG2SNeNOqKf6itNXVRATkNtIQBJP4qkHEst2cXeq/Oc=;
        fh=66GzX/s8lyBPT428SZvCCQejFJ79WCMBYSqpVWqgPdc=;
        b=rrVANsx0rLkoym+qfoZlaI+c2X5Kzm71dBYlyIGgBU8uxdL7GW+7PYYhvATrEs13/7
         lJ78Ke28i4iAi3FhtRyAzirSXujfn7bQ06kLRStJm/h0HV2QNvEtRXDadIn7tThL4guk
         pHEXQ6K/nubkyYnVfHVMCFbbDpLK+8HafVysDf1NTc8sPlr5GqbcdJotS3QPJZ/jj49/
         djX+wuZWo3zFYANtFeFAfy2ZbRn4zQ+5De+5ZifCSKxzTy4bo2BECq5BFK9UClkOBh1c
         tFXvmq4hHhrjJ8UFUBLtE2cpfzciEFjG3ii+lnNSl1IP3irnrDNOrVQCedWV1HQtfubw
         ZhrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1789198811; x=1789803611; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QG2SNeNOqKf6itNXVRATkNtIQBJP4qkHEst2cXeq/Oc=;
        b=OMN+nqklVDfMdt0nt/oR8IX/v2tMsZLPn7d5gYUNxzhpm9jH0ORZw2hKmqg8lWA0rB
         lzwa1bcYSLxPxJbrw0VCk6T4Zrq03uEZfbeDk1GQbLSbRhMoZHUrIySl0qSiMFCrWOe7
         LEDz/C7y57r0G14FWil9ccCN5nfGtSkZ/ryy2NWWN47c3JLy0cRu14fi5nIm2bV2P2NI
         X3PsPA4NxDRDgVqXTkSAsPvQEjMBtr9G6u8VZ3NCmxsYpM22RI1/40hd3uFJVOkbylCI
         e6otxTorETJ0MtznvOJNQLO3YpPQu/IADoppXDIwBE9my5qCEu9brIez2rm+oGKdeHNb
         UDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789198811; x=1789803611;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QG2SNeNOqKf6itNXVRATkNtIQBJP4qkHEst2cXeq/Oc=;
        b=RTYwYY5sawI+wYCMdVBPupzKT8YC8s5SEilLxoHGnd/DLndTYv/Gk2/ckstGS4Avdw
         EetI0/1Sz0U+WB+OA3h8R4S2RlzmuV5tjN3HWLyDQilSKIVcg3QVp8j0n6OsAUPk+J2u
         n78OalKIrHu/RH1jdXHc00LcOQ5uJJ8f9J9K4Jq6CkpnSMC/ZmWrTL0wU2akfpfnOgzR
         TFK/eBixM4NlV3SjAeb2CIXsOIlB9d8YfVeLgjDBgEXdRiqBPwzdIk6Mras+tFHI0+yI
         3WaZhbsGvO4EsNj4PnTQjObJGADEPJ0FuA/tVpz3QrFy00q+w1JvDTNr4PIiiy0+szk9
         BYsw==
X-Forwarded-Encrypted: i=1; AKwUvBxx6pmDqhSFgVgi1Y8s/aD6rLOz2VEiIbjEgQMi61yoHA9i0+cBSZSzDsGNnAL/M1xOIB7QMRo=@vger.kernel.org
X-Gm-Message-State: AFuF++nib4PBn7bZmKheq3Wg87aCiOLfQJH2cc2YKNTI2AKroA2a61Wo
	u/nKw5eSrbxE2omJcL48DaAN/cpw+/XDssZLpiwYQSLxWjbRRgtSfwY3yimzx1Ws0tCJfZQacm3
	8B86fQ763sl2sg8QN+2M1GFbZARVoO+hJl7jBGEoB
X-Gm-Gg: AYBFou3kaNhgwMZFixuk0Kzke0P7DmM3+H0tYDNKX8Yfi+7tD2+oF12s1HKMfyekJFG
	GylmbZV1yasoGde+D8FgfRmj0P8jwbmeiLV0kDys5UEwG+pJxpoIPZOaiuqQM2VdpQQ6nGdv8fw
	Nh5a3rPph6QGxavXib4+rvDnD5FFehovuUi0lciOyokYh/lbJQL7XAbIefxhI4HYKZ/qIPmhcvD
	cYopUhQJ896j2viufe03n61QU/qWyUlIh1z1NtDcpV9ikHHT8A1UHyMfhKlN5HvzBbmqRVubWpa
	lxJeXZ8Fh9sFcpokqkuBbtsntTz+4tSyOUeZns20IfdxW01KxtEhTxdDYhlE8oEcDlvm2I9pKHG
	Cm/qiz4CbDDh4XLUX7TexRm9031YuU6hY7X/0MLkahoQ=
X-Received: by 2002:a05:6a20:3ca8:b0:3d0:868d:8ccb with SMTP id
 adf61e73a8af0-3daed418649mr14691447637.13.1789198810266; Sat, 12 Sep 2026
 00:40:10 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 12 Sep 2026 07:40:09 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 12 Sep 2026 07:40:09 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 12 Sep 2026 07:40:09 +0000
X-Gm-Features: AcwNN1U7oiMPPggvAGkLxJ8f4FS-S3NfnynfUNKYcvJ3EJSPIXU-keM5UBnvdpg
Message-ID: <CA+0ovCgKDOk+Bg6Gh5Lwx94u_jJjQ30-vY1JcY2BYfhnWJJbPA@mail.gmail.com>
Subject: [PATCH net v2] net: remove WARN_ON_ONCE() from the
 dev_fill_forward_path() loop check
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: falemi@asu.edu, Simon Horman <horms@kernel.org>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Xuanqiang Luo <xuanqiang.luo@linux.dev>, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ipip_fill_forward_path() and ip6_tnl_fill_forward_path() look up the
route to the tunnel's remote endpoint and set ctx->dev to its device,
which is the tunnel itself when that route resolves back to the tunnel.
dev_fill_forward_path() then makes no progress and trips
WARN_ON_ONCE(last_dev == ctx->dev) as soon as a flowtable tries to
offload a flow through the tunnel. That routing loop is a configuration
any CAP_NET_ADMIN user can set up, and ip_tunnel_xmit() and
ip6_tnl_xmit() already treat it as a tx error, so remove the warning and
just fail the walk, as commit 008e7a7c293b ("net: remove WARN_ON_ONCE
when accessing forward path array") did for the path stack overflow.

Fixes: ab427db17885 ("netfilter: flowtable: Add IPIP rx sw acceleration")
Fixes: d98103575dcd ("netfilter: flowtable: Add IP6IP6 rx sw acceleration")
Closes: https://lore.kernel.org/all/CA+0ovCgaRvbd0Udj70b2xxG8Cx3CaCpNhnf1V4RWQuDveZYZhA@mail.gmail.com/
Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Assisted-by: Claude:claude-opus-5 syzkaller
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
---
v2:
 - Remove the WARN_ON_ONCE() in dev_fill_forward_path() instead of
   rejecting the looping route in the tunnel drivers (Pablo Neira Ayuso).
 - Add the Fixes: tags (Xuanqiang Luo).

v1: https://lore.kernel.org/all/CA+0ovCj+Pd5owGH+51rA8-RDu9YFx5oYUv8bV0zOE72QgVfY0A@mail.gmail.com/

diff --git a/net/core/dev.c b/net/core/dev.c
index ecfbd72d5d1a..c67900354fa6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -789,7 +789,7 @@ int dev_fill_forward_path(struct net_device_path_ctx
 			goto err_out;

 		stack->num_paths++;
-		if (WARN_ON_ONCE(last_dev == ctx->dev))
+		if (last_dev == ctx->dev)
 			goto err_out;
 	}

-- 
2.53.0
