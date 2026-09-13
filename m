Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1AA40BCA1
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339125; cv=none; b=YANBQP2iNw1HWGIVPESuMAYGlhGYXNaSz5ZKFZlr14Vpp6QnLOEoT6SJQpGf4T9J9vNVCB8ADAxuhFxXPLmkle1dpUW5M0XEn8uUoSvUJ8S1/TEEry4q6EO6v3T/IRZ6xhveS+PYb+z7Ta0zojbY1lz0gHMb/orZpSB8fq3L+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339125; c=relaxed/simple;
	bh=EdEhFEPlwUGH1Vq3Tshjsv+2eIevlycJTorg33rgApg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=D50SBp/AhMfahHc3o7HyeXC5Pz1rWBEpF8N8qa7PA4l3JA85Yc2xJgxJCF8rrIwgqzrnfB7fOgnOrDwsw+apAENg1avO7s/Mv6Ta4c/jrSWC/R4ETj/dTZOLXxxm0bTHBPsJNDsePJ3oAf/YNDOnWFcWR9/Mmi5snOFwhH+5Z3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nuajgUgk; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuajgUgk"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-8659af7454eso10198277b3.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 15:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789339119; x=1789943919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=84pp0ue0PzfDSGHWGkhqOFoNG0QZlDQE6znxPwIQxOE=;
        b=nuajgUgkDJJFteLcH8RfxTVmYSGgOIX3rTJ1u8gp+ijCE0/1Zw4YjEvgvPj3IzmDWt
         o/OPBX+uLIMJmFMWVonAEGkPnN2HIdXffxhU8zVu2j75pCBty7Z5IjhsUpPiavhjdyIQ
         nxsavrXq1QE8cn5iCUZlHxuAD8f/qKgZMQ4Bp8e3L2kR4iu8yfOfFT7/AEcNgfSCS5zG
         TdX9I5cnoxYADFJw+4QmlDqxzwLWld3AVWuMGlOnPgkTHAxAAIMmCjVeZ/bF4PcQ8Lmd
         F2EubbiifxG6AcC2AmynSZ7PR08xzf1XiJOnw5f9+E93ycH2IxnLQWZwGvOGECiCsRWO
         r6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789339119; x=1789943919;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=84pp0ue0PzfDSGHWGkhqOFoNG0QZlDQE6znxPwIQxOE=;
        b=UP7eY9qupOQfz+e27NtIS6z/TQDiB7R1WO/D0ANx5KH3ILX/2/stKCcvLzaKjEXZfE
         nK6lftWk+5OFBZ0/s2Jz6OR97Si1ri0nIvX5yhgq0ZYSBkInI2Gz3yVaP5CW1as+n3/+
         2Ej9+txJ4yTxVVz8xZc023NPlrzcKGZ3rmDU2l5PnavVM4sobKubZzlh8U2a0PdeJveu
         20YCsk5yGKZ3v29GKkz47luPK+wMRXOFlPich4F51n0+JFNkYIft46MOt5LthD/9yHWj
         gvILA3qwtsJr4FdyPy3J9RNT1tNk+hT565/oDFT7rc6dRhbE1o2DLMe11oVQ8ohWTMXf
         UACw==
X-Forwarded-Encrypted: i=1; AKwUvBwLv9DokWUJFnkhemumpkwnlhDgFKkey9WpR98lJy0mD6O3Xl0ActTcA+s2qJDPbPDi6Hfcn30=@vger.kernel.org
X-Gm-Message-State: AFuF++lre3POub1e+4c7vjFIKRHX50xN0NAB+P5GC2+ZgNWiC18ZN8Mz
	OTNsJvOORqxpGOGg6lW4wnYTtY2w/pIkyOmAcukcdFwN2dDVXRkxYily
X-Gm-Gg: AYBFou0+NuPp1EImHk26AmvRd1mpM1K3qRoideq1GWgQLTC3zRxSvPj9zSYKIFKQIR+
	fUGtW+2I3XhaHHJ+pwQMNE24V/dxLRdg9wPAeDv44nTarCX2YFxNPWIDp1H9Pi9fPg3psEpDoim
	MCZ+TTUtIDe/ELbs44qf0jwf4e6I68Hhk02/Grjse2CDwUotW+p4HLKvCVo3NJWdcwF8WbK0c0R
	bYLkUWTRkxA+miyNbOuqdNRvn7gspWKnqXp8aXwEaktp1zvTz7fIiIcB4io7pp8XA2bYmspXIch
	SNoNfkM0TUhr9VLODrTMnJbMzM/1qOucEmS72p3/R/emKfqpFJFGqnbqv/HsuYNBpbSG1gZW3E1
	c8aqjxHngYf9ga2BJqkaHNGxk4jtTjllafETGWRS9IaSXU5mt458Y8dj8hqwiejItcBqG4ImDnS
	ZlyxHs1VZdd51E3zzioyiavRUCcHUZngPsfMizysHGNfMM/WG8p2zQYlkX3xuujljZh5HN+WxJX
	eTo9zon+Ctnu8uMkocnbX1W2N0zE3uE6XetvbAzK++wT94z+uq2
X-Received: by 2002:a05:690c:4ab0:b0:873:5c0f:28f with SMTP id 00721157ae682-88d23c93dccmr162367b3.57.1789339118763;
        Sun, 13 Sep 2026 15:38:38 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-884878de7b7sm31470857b3.29.2026.09.13.15.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 15:38:38 -0700 (PDT)
Date: Sun, 13 Sep 2026 18:38:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mark Amirkan via B4 Relay <devnull+markdamirkan.gmail.com@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jon Rosen <jrosen@cisco.com>, 
 Simon Horman <horms@kernel.org>, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.34fbab8b5c5af@gmail.com>
In-Reply-To: <20260913-b4-send-packet-vnet-v1-1-5545ffb528ae@gmail.com>
References: <20260913-b4-send-packet-vnet-v1-1-5545ffb528ae@gmail.com>
Subject: Re: [PATCH net] net/packet: clear RX owner on VNET header error
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mark Amirkan via B4 Relay wrote:
> From: Mark Amirkan <markdamirkan@gmail.com>
> 
> Commit 61fad6816fc1 ("net/packet: tpacket_rcv: avoid a producer race
> condition") added rx_owner_map and made tpacket_rcv() claim a V1 or V2
> ring slot before converting the virtio-net header.  If the conversion
> fails, the drop path leaves the slot claimed.
> 
> With a one-frame TPACKET_V2 ring, an unsupported UDP GSO packet leaves
> the only slot unavailable, so the ring also drops the next valid packet.
> 
> Clear the ownership bit on this error path.  TPACKET_V3 already clears
> its block state here.
> 
> Fixes: 61fad6816fc1 ("net/packet: tpacket_rcv: avoid a producer race condition")
> Cc: stable@vger.kernel.org
> Assisted-by: Symbolic
> Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
