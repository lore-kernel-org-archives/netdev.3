Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910747;
	b=KV2+fcq2F4/Ip5ODq6geRXUnhCaB1ah4dbRHRIyAud6wtkB3nVgNJ8RNsnhF4nY8rSMp
	 LOyqzQss7a4tFD7MDFu6ZzcLxF8PrxmwK6DW38A6R+eCkqwHRsUMR8FFiSKgQZRgpILNQ
	 ubHqfwtHlHn2Zu9EUc36RpXuZH7JPM2aG2sdhz2D7tmSYyp991rwhqowD2NsUQhhWO7xw
	 VZDZIwunsSip230Z7NTF5PX+sf+dS+6zK6VCUpw6J/jjMXciBFOiVj3YoS5jrpcwON59G
	 TI8Rzhr0vt8WIfwdjNA0YUPG+Y/pmmMLFZ9cLUMNfvlw7qBAPN1iCYfgGNH771C8meg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aQ8r37ziw71fqDLMgR/NMnH4TFvaTayfpcX1AdbOmIc=;
	b=OfDD8A+XJ+ggP/nu0jnyayZDKCgJ02wZ+OGxqNH7pqwntZgMcty0oMTFcQOoCROsDMbM
	 AQi7DYGSCZMNPmcqr1ZXZiPtbmk8dTaLnMrhTD/NxAvJyya64JDxwvi9I4Glkdbu+1LBB
	 WizSCncP/J+76vZI2RQXK8fsHx1A91JeY5nX37T6HvRCwYqDjgKYSN8QLzEKRzM36DRQg
	 zP3utBK3oX93Jo7TBSfknePB/DQml+jpgqKOweALoEMmYzfqRSayNdDRaAzKxPdwaGz7E
	 Kep/HzYBPqbhy8FZWrKS9T96E0xhSDDHagWbNTXoTATOawObrT8SORisZw7EU+45y4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Ru2/jDRd";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E68606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 06:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82E68606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ru2/jDRd
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3535a54bed9so3323690eec.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 23:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792910746; x=1793515546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aQ8r37ziw71fqDLMgR/NMnH4TFvaTayfpcX1AdbOmIc=;
        b=Ru2/jDRd9N5vPqGUpovwLVR4ixtu1YauJNh+9lYcLXrvmtADygWjtWEDvtkCmLFto2
         ZMY2tb8UbDS4ORojtuQR/1BtHuSipq+qL9Cv7vykk2Rr9iHtQuo03zeQb19+9ymiG2J9
         XXs25OG+O4mPM2fZNG7GP3MSEZYDAb/NnbKh+QTBGIDGtTCHTEXXtb1R8q8wXiUyOzeI
         8qK8PaCoL7qDdZibsCEh8aPqDNX/fNefHFKS1B1SuyeqYe3/89EaxOYSgRT4M5e2j6ny
         bMc0wZA7+MSJGKLfM24L+dAvYUVOgPeg0myXhy1qxq8hjGAHZhGX5HAsvgMLmkgfOca4
         sO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792910746; x=1793515546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQ8r37ziw71fqDLMgR/NMnH4TFvaTayfpcX1AdbOmIc=;
        b=H4G70yvvlhwoj4jNM/0zhJ0h+i78sXcDcy71wvewuS2V+Cm+EKM8o3WJBrG/25MS/u
         Rsw3nmHalfMJexS9nG5EObEtxQjb7qYn/q+bQCpmUnZxamglYIpgfASwDEdI/5ocEdbo
         a8u2zsydKcGDOE7bFkqN0hW9K8ZUihUCFNrp0n5MRjWgg+2OHAzTqsbE1CCaN1runTc+
         7PstGJVX+PDJEZWDxN0WRwbNI1ZTaMnBSJ2en6FdxRgGJJcKXJ1o1W3SqRdEWmrfg507
         +dCwZRq1FD4+eegBmdXfj1rzkG53dUdSqvzHn5yxeF3PT6x84PAptUU7kIvcrNYy8NLj
         wseQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPaVrPJx2dCtX64RxN6ZVtFxdTRTYXCBm9UqsvkWsfJ/zb34akukOoztdTvtUMx8GBAuF/wY8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZjHCvIh97Q4ODeANLII9Rxb9Abr/bG9+dC7kKSc5KOdWOxIMo
	YoW6At/GH40Wvj09OAxpcHp643h8cmBEsLuD/Peq6pkMUzoee0ASuVyX
X-Gm-Gg: AYBFou1J1mB5xjGAh6psU+OHk2NFxmjqexyDR/s2a6uuHVQATcPFgfXYutvnpgVX0mJ
	bxXhmrGkjWtVgpoOso8IiSbqdquQ0LhzkafhUO6X9aFAFxwj2cb8wfDz2jLkDJ8/X0xdzOcAQ8K
	6MoI6g2V2UyLc0scCdLDsw4OuLDKaqYqHeYMgpaeXFl8a19K4iVO+ddljx0WUZBRk0TV6HAA37j
	FiESFbTZgzUdDIk/TKMdlAPiPw2IWMo14tyJlSc7SxSDAu9ql7jU+7m6vwzZfarz7SMWaesMJFB
	IGQsSh1sSdL7Ry62dz6urJJOyEFsHq5Ei73JcmVM3WvRWU9lg7SqVCaTBOJJMEH2pAt6kWbHOQj
	n15s3G3slrZOwyaI09aPd3gJz8wQ88Rc3aocSDzx07AFfG9OJuq5Ztp2/vKqqRNAU0CHYxyN1lv
	s2pn/nkIAzGoJnbbfZ16A9kEsw+Kg64BfjMGOQWbDQq0MWFS57n0WobiVXPgsyQ1SIyyKRfaT47
	Qknm2y2thjKUKv5W/h805TJBmTRd2rYHZ5zBmnrrGg7TLwbHeV2mhSp8kt/+Don56A9u9bPHhp/
	3omZXjEkaFWtty15KkEPiBhIZ45g4ds2Zan5VcgYxrqqmRO6peUY4JQn+se82K2KG3HouaPbK6M
	+uaJu
X-Received: by 2002:a05:7301:1a01:b0:369:d735:e9ad with SMTP id 5a478bee46e88-369e847d8c3mr6076025eec.21.1792910746367;
        Sat, 24 Oct 2026 23:45:46 -0700 (PDT)
Received: from localhost.localdomain ([2600:1010:b094:72dd:acb2:1ed:a440:33ae])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec865esm12371219eec.26.2026.10.24.23.45.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 23:45:45 -0700 (PDT)
From: Zhixiang Zhao <matthewzhaocc@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Zhixiang Zhao <matthewzhaocc@gmail.com>
Subject: [PATCH ipsec] xfrm: state: use the fallback SA while a per-CPU acquire is pending
Date: Sat, 24 Oct 2026 23:45:24 -0700
Message-ID: <20261025064524.74618-1-matthewzhaocc@gmail.com>
X-Mailer: git-send-email 2.54.0
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

With XFRM_POLICY_CPU_ACQUIRE, xfrm_state_find() uses the best valid
state directly only when it belongs to the current CPU. The non-CPU
fallback state is selected only inside the block that creates a new
per-CPU acquire, so the packet that starts the acquire is sent over
the fallback SA.

Once that larval state exists, xfrm_state_look_at() sets
acquire_in_progress for it and the new-acquire block is skipped. The
fallback is never selected, x stays NULL and the lookup returns
-EAGAIN. With the default xfrm_larval_drop=1, every further packet on
that CPU is dropped until the key manager installs the per-CPU SA, or
until the larval state expires if it never does. This contradicts the
comment on the fallback selection and RFC 9611 section 4, which has
the CPU without its own SA keep using the SA available to all CPUs
while the per-CPU SA is negotiated.

Use the best valid state when an acquire is already in progress, as
policies without XFRM_POLICY_CPU_ACQUIRE already do. No additional
acquire is created, and a lookup that finds no valid state still
returns -EAGAIN. The fallback is not added to the policy's state
cache, because that path still requires x->pcpu_num == pcpu_id.

The loss is easy to miss in normal operation, where it lasts about one
IKE round trip per CPU. It can be reproduced deterministically with
strongSwan 6.0.2 (per_cpu_sas, start_action = trap|start): establish
the fallback SA, stop charon on both peers, then send one packet on a
CPU, which succeeds and creates the larval acquire, and a second
packet on the same CPU. The second packet is dropped while
"ip xfrm state" still lists the valid fallback SA next to the larval
state for that CPU. This happens for both IPv4 and IPv6 traffic.

The problem was found and the fix drafted with AI coding assistants
(OpenAI Codex and Anthropic Claude) while testing per-CPU SAs for a
VXLAN-over-IPsec deployment. The analysis, reproducer and fix were
reviewed by the submitter.

Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
Signed-off-by: Zhixiang Zhao <matthewzhaocc@gmail.com>
---
Testing (not part of the changelog):
 - Built Ubuntu 7.0.0-38.38 (7.0.14) twice from the same config, with
   and without this change, and booted each in a 4-vCPU KVM guest.
 - Setup: two IPsec peers in separate network namespaces joined by a
   veth underlay, each with a guest namespace behind it. Traffic is
   ping between the guests, routed over VXLAN inside UDP-encapsulated
   transport-mode ESP (strongSwan 6.0.2, per_cpu_sas = encap,
   start_action = trap|start, AES-GCM-16).
 - Without the change, the reproducer above failed for both IPv4 and
   IPv6. A variant that does not stop charon, and sends one packet per
   CPU right after the fallback SA is up, lost traffic in 5 of 6 runs.
 - With the change, both tests passed in 6 of 6 runs for both families,
   and no plaintext reached the underlay.
 - The same code is present in ipsec/master and mainline. The patch
   was build-tested only on the Ubuntu 7.0 tree.

 net/xfrm/xfrm_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 0555e5d796ed..dec528f98d51 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1518,7 +1518,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 
 found:
 	if (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) ||
-	    (best && (best->pcpu_num == pcpu_id)))
+	    (best && (best->pcpu_num == pcpu_id || acquire_in_progress)))
 		x = best;
 
 	if (!x && !error && !acquire_in_progress) {

base-commit: 835912998ca54a76b5c57f8c8459a86b1b45de40
-- 
2.54.0 (Apple Git-157)

