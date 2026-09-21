Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4D78F3A;
	Mon, 21 Sep 2026 03:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962505; cv=none; b=GfgJcN8iBW0Tstlm6KtsPp2DPKy5m3G3X4T/QBlTnLuwRirkxL/7fDjzF/k7ZXIgtV9/W1zyza0FlCTSJ1NQcqVUKupXsSCruUV4CThwqCtYlngh5G+B9uED1ayzsv9vnwuEZpv0aptSIdOu+vm2+Ve+b1OrTNmmnASXNrsCc6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962505; c=relaxed/simple;
	bh=JW77XHcXbaZUmt7s44GHCJtnB/MlCkgLLVdM3c03FxY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XghOfULz+kYzHJ2stbQv8G4o3tgou0QZYQ9jLqDh4zGiX0r6yisEUaD4cJX93y9ii4styVreAwp4Sa41xuD7ZeHBfrmiYukEBfcWt0BQyfrgfTSk7/ivhyssDhAHmwxsDPXQ4oVNKJfv/zoI35mIg0SPDsxPZ0RBrYdmLlOBhSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXFf1lpo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXFf1lpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00621F000FF;
	Mon, 21 Sep 2026 03:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789962503;
	bh=wWj4XMbi50YlwTCH4OHzPxm8EUjOl3BKv4hKfkPzX/o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aXFf1lpoMeKQe8s8QReZs7bK8kZkAJhdAGBQp5PGD9AVrjSJNd/Te8zXKmrlmKqxW
	 QaKldb1DjlPBSknmGTYWU4obdIkL/vhmnqhLxoNU0kdn7wgQxLzYtvPg8h/t13xXtq
	 5zIdOF4oLxh1WsQaghosT02cg2WtKOEYZZvErK21aUQxjuqaynVmM7ZjWFMDYF1OHI
	 JSSSqEJDRkN6jDqqkTVizLiy07NzGvIeP4oXbe1OZi87ioxBNRkm0e+Qjdqk9VmPOu
	 b6gn4BHsgMKM3LlGLXX3XeYaer4XUOo3WC+4mrFRFUT6aJmdQVPthpdyQ+H6uiLSts
	 iAkdtK3SJgaCg==
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: qcom,bam-dmux: Add
 memory-region and qcom,vmid properties
From: netdev-bot+sashiko@kernel.org
To: vishnu.santhosh@oss.qualcomm.com
Cc: stephan@gerhold.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 deepak.singh@oss.qualcomm.com
Date: Mon, 21 Sep 2026 03:48:22 +0000
Message-ID: <178996250211.2160803.6013516663876593386@kernel.org>
In-Reply-To:
 <20260920-qcom-bam-dmux-vmid-ext-v2-1-ef5ca2178378@oss.qualcomm.com>
References:
 <20260920-qcom-bam-dmux-vmid-ext-v2-1-ef5ca2178378@oss.qualcomm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] SERIES-RESOLVED (retained for policy combination only): the
  concern that the newly documented `qcom,vmid`/`memory-region`…
- [Low] The `qcom,vmid` schema contradicts its own description: the
  description states "The local execution environment is retained…

--

dt-bindings: net: qcom,bam-dmux: Add memory-region and qcom,vmid properties

This adds an optional memory-region property pointing at a
restricted-dma-pool reserved-memory node for BAM-DMUX DMA mappings, plus a
qcom,vmid property naming the remote execution environment that is granted
access to that pool via SCM. A dependency entry makes memory-region
mandatory whenever qcom,vmid is present.

> diff --git a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> index 33746c238513..5351269b0ab7 100644
> --- a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> @@ -72,6 +72,24 @@ properties:
>        - const: tx
>        - const: rx
>  
> +  memory-region:
> +    maxItems: 1
> +    description:
> +      Phandle to a reserved-memory node compatible with restricted-dma-pool.
> +      The BAM-DMUX device uses the pool for DMA mappings.
> +

[Severity: Low]
This isn't a bug, just a note for the record on an earlier concern that
these two properties have no in-tree consumer.

The companion patch in this series, "net: wwan: qcom_bam_dmux: Assign
restricted DMA pool to remote processor", adds bam_dmux_assign_dma_pool()
in drivers/net/wwan/qcom_bam_dmux.c, which reads qcom,vmid, resolves
memory-region through of_parse_phandle() and of_reserved_mem_lookup(), and
then performs the grant:

    ret = qcom_scm_assign_mem(rmem->base, rmem->size, &src, dst,
                              ARRAY_SIZE(dst));

The pool attachment itself is handled generically by
of_dma_set_restricted_buffer() from of_dma_configure_id(), so the
"uses the pool for DMA mappings" wording is backed by existing code too.
Nothing further appears to be needed here.

> +  qcom,vmid:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 1
> +    items:
> +      minimum: 1
> +      maximum: 63
> +    description:
> +      VMID of the remote execution environment that is granted access to the
> +      restricted DMA pool through SCM. The local execution environment is
> +      retained automatically and must not be specified.
> +

[Severity: Low]
Does the numeric constraint on qcom,vmid contradict its own description?

The description says the local execution environment "must not be
specified", but the only constraints are minimum 1 and maximum 63, and
include/dt-bindings/firmware/qcom,scm.h has:

    #define QCOM_SCM_VMID_HLOS          0x3

So qcom,vmid = <QCOM_SCM_VMID_HLOS> passes dt_binding_check even though the
binding text declares it invalid. The 1..63 range looks like it encodes the
width of the SCM VMID bitmask used for BIT_ULL(vmid) in a u64, not the set
of values meaningful for this device.

The driver side in this series does enforce the rule, in
bam_dmux_assign_dma_pool():

    if (vmid == QCOM_SCM_VMID_HLOS || vmid >= BITS_PER_TYPE(u64))
            return dev_err_probe(dev, -EINVAL, "Invalid qcom,vmid %u\n", vmid);

so the outcome of a bad value is a probe failure rather than anything worse.
Would it make sense to encode the same restriction in the schema, for
example with a not/const 3 clause or an enum of the supported remote
execution environments, or otherwise drop the "must not be specified"
sentence so the prose and the schema agree?

For context, neither qcom,rmtfs-mem.yaml nor qcom,fastrpc.yaml places value
constraints on their qcom,vmid / qcom,vmids properties, so an enum here
would be a new convention rather than an existing one; the narrow point is
just the internal inconsistency in this file.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920-qcom-bam-dmux-vmid-ext-v2-0-ef5ca2178378%40oss.qualcomm.com
