Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793703520;
	b=VKbWLQtpWiPtLjrM8zkkch6T7LUj1u6EouiLHgayk0wCabhh/B2e3u45ARDoj6HXMNLG
	 ml9o0+OLom8OS4O8C/GO2ksLLt865z1fV/lA7EYNz1UE5fIocgCyK9qgYxpQZBzdWVC5O
	 NVHFpIeO1kDl0OdFamgwgjOX1rE3Rl+v9WZRxFNTEUTNYwPKzxJyDS6WZh4IZTI5JlZIh
	 7iib7zrhxoi8g5kKY91f3++WLtQBYDyXo0QMd63oTGzQl/N4Lf3V0cJe0sg5OBtGIrWoT
	 XEAXJ3TPB/Um7DN/bM3q5BXPgk1wVviiuV8EB9kXTDKHoIzZZi1m6Hn7bT9KdZ3VvXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=4SxV/TTUmbx5pwC7iN19KlLB2VY5Hex23bqPEZJhYdQ=;
	b=1tl/UrcjnFwJiL7E+F5Y/AOSp0CvsZLQnZpllhc0hNkODYcAP3/2WeQrXnBC47GQTM3h
	 MaoX1kOOyZEEvI1WWAVYF55AxG6LE3JMfDhKABr0Fk9TPXUvlopF06KtBm4V6sIc0Kojv
	 HwrDMAPkZus1Yyb8RgR6Z8KcBeb/g1fD3hhhLr/5XLAk3OqDlAU7n2N0mbfbqECfa7wPk
	 3XkWi0VUILh2j+cAeAjELBT1y+a9axysgJ3MOSZLD9exAaFE/dFJIk/ixgVB2zCfdBxj/
	 AsFf4LrXXm+IvrYyq1sJlctCHOi87Czx+a84jXsi6c0tqNF29VPiqWFKaWUY39DUXgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rw9S2U+A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8FD6070099
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 10:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B8FD6070099
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rw9S2U+A
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a06b44bd01so2171728b3a.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 02:58:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793703519; cv=none;
        d=google.com; s=arc-20260327;
        b=m64ufzJ6hTZNY5qpdEWbZDs1Bjstq8rqcpqpDvfyxo6V5bzihuDqm45R1mKUTJR3rv
         KcC4N6g/CgOsxVQY5FgDIZfNcMCOIWOCFMcXGqIZEo3+4rXnR81aJneOuTrjaopNpLXT
         +tyn25CfpnhaBzOUf8xbVbsYy/8OkM5wO4ETVOnlrBA9FuG5GFRIlijT+Z4U4fSKZFtg
         xW0huEWQZJtAKSM3khD28PXEycNU+fqSNrE4lWMkw5FoawS5t8mOLIw7xO9w1ENPNmve
         M0QTyUxw2BEmMLTIr6UV9HDKcw0l2yDorHvGX7RQuKyZmYwQnbyc6RGGEEqeuuJp7/ca
         qW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4SxV/TTUmbx5pwC7iN19KlLB2VY5Hex23bqPEZJhYdQ=;
        fh=Z/MDTq1voyuqw7A1eAydEHvw/EE6XvHuKV5QOlJA/aU=;
        b=NBd4zYz9lmfBe7eaqN9VEf5vlz4Qe08s9r1yS9WpJ5DJnfQzSXsSTsHjFyaRrdNFKM
         +OmNXOgz0c4BBlK9walwOXowtkIIZZ6satjdiUC2BrOXymMKoakZO8ZOGbJoyRBFnPlO
         jgJTuv4DYRQuhUTjAZ1LZT4/PSKD7qUyHZQDBPnVrj86B7LX3rkhPTK20eRmtQyS3ugu
         IazUEsQTKUxDaRgvG+h9Kaq+Bihny3osFjZsF3gv/VBkKqKGGp5/oYThvDkakRDU4r0/
         pw8X5qLQWCeOZ/AAMOihQxT6H9mbWO8lHYzA0fP7VHw25avW3YfST5V/QwP+FAT22eSp
         7Oyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793703519; x=1794308319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4SxV/TTUmbx5pwC7iN19KlLB2VY5Hex23bqPEZJhYdQ=;
        b=rw9S2U+AlSHzlzFau1E4CEO32us7ZWTI19zuQfIKoKUYkPQTPNp2mBVeYyNI1Peol3
         r4HPJvCt05Ad8bt0OdqRhZJU/2MGPm1UImx2c1pNBFQeVKjHRt2p0DJtO6VAI8QtPIgR
         JCd8J6qNyy2qXCpM/YHu8eZfiDculaeAAq1rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703519; x=1794308319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4SxV/TTUmbx5pwC7iN19KlLB2VY5Hex23bqPEZJhYdQ=;
        b=rDnTvk8n0ksPJFoOU/ZENvGuHSbBLQQKp5h/zVoNFX2WetueIfW95HxQbtOoJrXjN7
         TAbRC408UmHYgqR9n1nuYknTbY6SEzsZZrPENHQBoIe+rzRVwL0q4t97fVv7RQu3eecX
         ICEzXeik+rabcqqvM3R6e+j/fAP/mOCMKKv2KNs5YlAMBUolfJFg5/Fs8XN4/avkSscq
         P1by1sE3YUtwKTCWNPzUxkRhpgWHTHu6sL1jIHrO/JHkX6kn7GtqoIiDuxu01cv1H0GJ
         wINiUiEIHp6qCxksBKYnWDI8yy7XgP83DPxXs6jmB7UUBzKK5hNBNhgQ/ZOvggcf75AO
         bS7A==
X-Gm-Message-State: APuU4Z86WnKb86HTHAzaiMQD60hv95tFgwlW8F/FPz+eoQ1sMtsUUR1H
	9BocDF6mCKjyVf378DMEh1ov0TbNtAO4rM2RzYsOlvofdfvpUNAcn8+epj0/PzCIb/20lLxGhsO
	kjmZoBi4X5jJZaEXlhhCL6DtxRG99b/TCf7Ugj4Ns
X-Gm-Gg: AYBFou2LanNWKpBiVYGOiF4AK2WBLhB85Wsyw8YdcFuPSoQaZ7JPs74abUK5FXYd2DZ
	akkuOaAYmi85+bNYZO9tb/b3Au5ISub+JgjQAXwtzQMucoB/DmxYNPcBk5ZMm8UkqBoMcEXnCb/
	Pu69c4ANaKeS+w/4NVB36daOT0+9lgvD6RbOeJay9rR7DqAaECtj9bwVpstPz6Llh9aJlcz4dnE
	Gam5Dw2AtgDE007J/XJS1+Bz8suiMD+PfZa+ygZFjPjl+6JtueqybGwYaKNpAmx2OSam/jC5eIj
	BGQhUe8W3tcrBLZmo+QopS0oQ4fowNrL0Avj9P0417Tu7rP5XqySnKQGRXC9OkDXvxxLIXLorg4
	gaP7fH4m7DxxyB2FSgGCGh8iWjW/+Qy5SPcNnW72xfgb51/2oHH2GMAoqgltMRamNxgY07aDS8v
	cYI4VRn8IG7qrzpU8=
X-Received: by 2002:a05:6a00:600d:b0:892:e080:4ed8 with SMTP id
 d2e1a72fcca58-8a9bd7dc8bfmr10230820b3a.47.1793703518719; Tue, 03 Nov 2026
 02:58:38 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-MD1X.v6.r0.20261029162633-1@mojatatu.com> <20261103105015.GE865646@horms.kernel.org>
In-Reply-To: <20261103105015.GE865646@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 3 Nov 2026 05:58:27 -0500
X-Gm-Features: AclHuK_L3JcYv2zsBzLTiCwrbJ18-SV_6t1OLvaKXCNLVHQqk_NRsSESvoMnaDM
Message-ID: <CAM0EoM=-bcqRyCoFxNy1W5e0xNierigGe6qbPQ-MCiwqrgj6UQ@mail.gmail.com>
Subject: Re: [PATCH net v6] net/sched: clamp skb->queue_mapping before
 indexing the tx queue
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Sashiko <sashiko-bot@kernel.org>, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 5:50=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> Hi Jamal,
>
> I think this one looks good to be merged.
>
> NIPA-Sashiko did of course have something to say [1].
> I don't think it should block progress.
> But maybe it is follow-up material.
>

It is pointing to documentation that is certainly followup material.
Let me review the other sashiko reviews (pun intended).

cheers,
jamal
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v6.r0.=
20261029162633-1%40mojatatu.com
>
> ...
