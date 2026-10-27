Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793077813;
	b=iKQ1xAA33t2E50+CH77ZZGRX+SZXr3DSgHyw2yWzRjSLQJYYKfWLTW11fSbj3MgW/Rio
	 BniE4qIj94+aASm2eOleLy8aUcGGCsmHprr9IQdRR133nKHbWqrIDc4QZb2vJUOFE7SAY
	 rmh3SPdgYzjCZNnWVvRQ2pXNEdQVOD9fsMIMKHCxPbh2SFvdFxkshK8HbwwC95fq0ASXI
	 WHLPCBX9ecoWWYNe/jTg14aazO5TTD0V1+MW0WgIin5n6bdhy3MaBZI7qKfwf1lgXtaai
	 qJGnFyyvWZQxSC+wP4k563PfDfKTlasR6kHhlYjTSISuVLCHHyJBrZSiWJmAPCKjupg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793077813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EhQnVDe9USo4MEDAt10lIRyoDXqtd5qy3HB/D8OuXxY=;
	b=isOs62QZ+AV+zTl62eJ8Phel+hPAKnRKURMwyw5hdNOWVaATWYLrgP74kHqMTmuFkhVY
	 QcLgDBVO3vtH71eAaCr3poDCet6RIGiYErPCSgOpipnzX+GNFsERlrHgHFMLPgR11olrn
	 5aBR+TVEFUvDWfXt4V+8oCSs8/lWEUge1+adU0jykQauL19p5DOfCNCQM7nS5++YPKPL9
	 /h+ziHV3YLVKeo7MP1ht3g1j0HMBS60f7FiF3xnZThTgqZV1jZQuUjLdd+2SAV+c887XZ
	 ccAJJI52mo52HVJXBF7zSZ5o/uPrFJUT6JXz6TeNSNNsgnEBGwjvmmcURmClokMnrhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bvhShgG7;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A206B606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A206B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bvhShgG7
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so1112993a12.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793077812; x=1793682612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhQnVDe9USo4MEDAt10lIRyoDXqtd5qy3HB/D8OuXxY=;
        b=bvhShgG7D7zcmztInFea9OSn7D5JSB0D4i6yf2n+crTq7yi8sQ9L3LLKQSM8xXnhkp
         AqbuI5FqtrdowocluYV2ukrP3D2+6rsKCdi1Z41pOP7b0xldyB01FWsU87xcrM1ltKwt
         kcr3vYsZ4f88sTfTaGS/12FRaQs3mo6OTf+MfJiFNZx7PdYwgY7Y/5XkHklFZ3etM9nJ
         RgVAgbYVxMhelPq7iSNSZhjFSWLaT1v5Vhtg/pvm67NtxQsd+f5YoS+gOBVzn176vHZz
         MPR2DrAz13Zck1vA7Ep9FKsc3GjKSyDQCbtFP8lGYIvNws58FuwvoNcq4dC31tEtn1pQ
         v3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793077812; x=1793682612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EhQnVDe9USo4MEDAt10lIRyoDXqtd5qy3HB/D8OuXxY=;
        b=HGrJs5cKSN29IpBgGhh2bKdQftrwCPO0RHP08t0fhuzuC9olZg+jKPDMMUI+TUiwqj
         ey55p6UoB0OmODbAw38ID3gidTxqJRtqJbgsSTg+ms/ykUGnWzG6nUz5mu/xnHZAEQfJ
         F87BjrHXtil5nwk2EoGXZrTgqmHNK/KrUpk2p85GXyEvmJ1+iN4FRGBirANJbXcerJUz
         DJoRYoeYgvKNoVX2lNvHLLNp/3gLmHxsxhV30bWoUoBJ9ZVgzH3IVa8KLxoOEVoLU82X
         bC0ZENZv0u69GEYzyBgLw61/mdjEGtS74rGgqAGQYXvuUIQBQmXSIZRLoxTSYKj55GQ0
         LYEw==
X-Gm-Message-State: AFq9FYLv95g/vVvAp/7DgXrmUbAjj0H1K0zQawIaN+qMmsxsu+nWihL/
	RjulzFjvXhX3xwiQrNaBNkkkAwuMX7AaoO9zvGi8eZ632LRCe1elOYPLkEz3f9yT
X-Gm-Gg: AYBFou0/ktOxfRKivKwFvFaWNdRv/jfAJeVEAuRnkSEOVT/tMz+RxaPhjep0iZzF+GB
	+uYIzdYb9ulEXnOGSwVGE7HButH2uyGnUscw96/XlekLqCJdF2BdVgBSx8B484cm+rE3YYGNI+O
	afJXR7b5QOjkynTKrwlE55IM5zrX0bwBGlIOmq9J7HfbYSr4HWFrRMtxlZv5y7y071IjBGwTkPL
	t8fzRCUmRn9Lcnkq4+RxzDBQ4iyFg+u8jP7o4bcj33RtIWEi0Jzy3QPdqHGMbtUOtIXY4q0nlYi
	gHd2feblbu5+3dC+97XXtqaVd9L3eKY3QAW0bDb9oKGYZN75TBbAVujbSGst1xukokskW1YVvqF
	BUciiduiTYFXvon7JsCirI5fkUUGM1uNH3wbTQdKzvkPMEEyPhioOJ2rlRgP3Q6brlGNiYXrAD4
	5/0I9huYW0uW1n03WU/Nzq7FMpfhJPW4AMVksEvcln3GiFnjgtzgLO0JzLCdmwxOTEuBY4wDJa0
	VkZwA5sCAVvHtg/LYFZXRNYPTNf30H4lCs7Iw==
X-Received: by 2002:a17:90b:3b45:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3ade9b2cff5mr8125294a91.1.1793077812053;
        Mon, 26 Oct 2026 22:10:12 -0700 (PDT)
Received: from plex ([2406:6d00:a27c:4200::7be])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404556fbsm1893858a91.11.2026.10.26.22.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:10:11 -0700 (PDT)
From: Chris Scott <gilroyscott1970@gmail.com>
To: lorenzo@kernel.org
Cc: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	pawlik.dan@gmail.com,
	zhengping.zhang@airoha.com
Subject: Re: [RFC net-next 2/3] net: airoha: npu: attach a coherent pool in the NPU window
Date: Tue, 27 Oct 2026 15:10:02 +1000
Message-ID: <20261027051002.3360392-1-gilroyscott1970@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <at8FyOLeaMlpS7mR@lore-desk>
References: <20261024154150.45733-1-gilroyscott1970@gmail.com> <20261024154150.45733-3-gilroyscott1970@gmail.com> <at8FyOLeaMlpS7mR@lore-desk>
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

On Mon, Oct 26, 2026, Lorenzo Bianconi wrote:
> nit: what about creating a dedicated routine for both firmware and dma
> memory regions. Something like:
>
> +static int airoha_npu_reserve_mem_region(struct device *dev,
> +					 struct resource *res)
[...]

Hi Lorenzo,

Thanks for the review. Sure, I will move both into
airoha_npu_reserve_mem_region() in v1. The pool attach then moves
ahead of dma_set_mask_and_coherent(), which is fine since nothing
allocates coherent memory in between.

v1 will follow once net-next reopens, together with a binding fix
from the Sashiko review of 1/3.

Regards,
Chris
