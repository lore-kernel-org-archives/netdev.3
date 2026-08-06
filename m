Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFB3371D1E
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023428; cv=pass; b=hV6+i16QDgQeZksZdffhA2dUR5syUWxWE6g/actXvhw9GAITstoLxNWtqPplph+AoA8LGm8Vrmkl+qU73RSluq8WZT+Pi5Zr3+8y8h3vY1uVFMQ8cYMxIYKDFCv1BL2Ojkx9FxacFM/JhtHrOPg+69hqZnjFpAk22fhTnnnAY70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023428; c=relaxed/simple;
	bh=vIo9KN/2F5hDvRyjDwzqZzAik3ta1riw0vF1bSwOf64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwmgO0YxgXs2in+/kzxlkb+KWxQDwaUZ0lYG53WWOryJWwBgFlvuxhRBOgsd/5xXDk9dvlLjl4EnrxL8wkQkapeBzvkxWUn4Aysiyi0nTWoX5t/oWhtEY++dBwfP+ueWeh/Ighn2TF8tLhfZPjrn/x9WTRQpE6Grtn8Q3rkanZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUh+GDp3; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUh+GDp3"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-698aece3d7eso350908a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 06:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786023422; cv=none;
        d=google.com; s=arc-20260327;
        b=F7GihiHHogGa9+6Wdo8WGcUBuiWWbqMkHzyKTo5CVGxuVjEwCwZbXnCYnwI0s93OCA
         l7Itjjas/S+xVz+BBLCGAhah0+lHOcMubKbwj+Bv+iVlaoA1od5yssZpeIJXcXvGGAMo
         LMLMd9OWJor21k9dOYko0chiun1MSMPzOgrig9kJ3RsdlNguTPYPkG1AameMyVAYMEdc
         VMcjWuNi42vStk8TpDSSf09ID5FJ0ZIThXmuHYv18VpX06JeFU/ibsiGA0tEgacviL8U
         IVvMuahTetE0BTjnQLbQWMIHLM6pQYaSkAqMLlNHhmNO7iA97x3GDPxSovY8FUkyGhhE
         +gyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vIo9KN/2F5hDvRyjDwzqZzAik3ta1riw0vF1bSwOf64=;
        fh=TFuwVz/YGMKCotKr93k8pjK+AQfVflwE6tfIt7NLUwo=;
        b=V/2NKsjBIygfmgwBDr/LIUS6gxVfR0IhuIjux0tlBSofsZ7edDFYO8ihYRC77PEzbY
         UK88juS4cFt0HOp7f/1XPA8S4aRfQZMUeTt1efIGlOa/yq3YdR8WEzyqBhAdFv/P0h7F
         NPgUBy9pun149BGxrGCTT/mGSWYbaVaz94jhBp3ME47I5Cf/P2K+5lnBHbUMZ8WtFGsj
         12fmig7U03YR9PZwNA+fOfJFMeiTdOKa/XxFRWl9TqOrKAhb93pSS5abUkLZHzcXEyxZ
         Yg3Wb6RZOD9WUcs4kG3lDN9v6gE4/PcsXjchsNy9iBMEMugTwVS5HiiTJgUHBtU+75uD
         Xiog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786023422; x=1786628222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vIo9KN/2F5hDvRyjDwzqZzAik3ta1riw0vF1bSwOf64=;
        b=aUh+GDp301nAvelaJRFl8w7FZiAIPsQPEeBfFXoHkGlCTvukdLe8migAZKVQk+VDxk
         SwN+dTBt9jqCnOSiV1xSOwOAjmqDMPoAPD7qBnuyIcqXKGfF1CNRyz2LBOSnI6+qkALz
         GZeYFBHu0SLPpNuLeb8xzz0RfELwBU05qffbcefH54puSx3b32ImbIEEgvk8yVu/5G/M
         O8Z/mpysLBCPBdcyej+3fcRkqEjy9TgFeugDKba1YeNyotJHWCCJdscBkq+92jiImpqQ
         p42JWBq8VzSxWFxMvbViJypK6Zppu/M6YVSN851vgi2/0xCWlDrU9f7sOLGGGZg3N/1z
         gzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786023422; x=1786628222;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vIo9KN/2F5hDvRyjDwzqZzAik3ta1riw0vF1bSwOf64=;
        b=tRXcwjQ5dnyTr5EFPeU4/ys/SuAoxOnCPIJqZCMXRMKeXr7plYt+f1Yh+IE3DVoCOe
         qwbuC4Z5O4QZt0KY6BYIRLfRmr6npdkZeFOyYSYnBuGMQNt+E+wk9Qxq7++7mp+N/R+s
         kLTclexw/J9pQfdshhpHscfzvLmYSCCXLCir5PE/l2zixDPCOHKuwyPRZIqU/KmxXpxy
         /XWDzo7pvcevIHwRPDXvkYxiainQ9FUyqo+SpiGm2W6LbfYNi4pTEdPewdp+LlwXkGKR
         Y6QkIqA4IXPGCIvvowi5Ia+2l6rsqIfhEkI7puRntkZv8DNl6uAu2gtilGRmejLwWsgo
         VMQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr+iGfhOP+CQ/GtyrVxTww7xpRjGpe890clZkmpUNzL510lwsGv0su/hr+KGuDbdl4I164WrXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuSw3UewAiSoHsPOG4vtEJA3eVQX67rhmBdo3w5W84EBQ888YG
	l0jLrmlE7SYvnVv7vom/ecqklBjYyIOE6YPOOWvSj3fgF0s+NuVdqJwPv0CpjJ1Ke2BY+QmqAVC
	cxAFqLO3YmiM0ItteS5wMtOtH8CufX/M=
X-Gm-Gg: AR+sD11r/7DbLa2SG64FQFp7oz8vueZsgFoY0pBZAZUnG+feJ8nmyjo9kzkbAkEukkh
	CjoJP6BnZuP2OsPRm3M0u3G50AOCLrcxmU8+sumzLbH7DWBufN2owxiqfftLdWn+THk+ttQ/r0k
	kPEYB5FqJU1RXvIKnyLU+2KQqyelFvKHvnYuVkOnTbdckWhNfmi/zw4BZSR8JIT1wllI6/Vr+ld
	vnBmWRnA4431FIqzwNg+bf17amx81+wEK11SjcLUZwUKgo0S+B7/liuvyCSUVWUpWqatuc/vYlo
	GSAACSlqUq/exQ9XjMZ2MM1k1oeyZP3BquQcmKx5EPYOJI/4Kr61olc8ORmNZuM5zEcWE602SQ=
	=
X-Received: by 2002:a05:6402:2743:b0:6a0:10c8:8f2 with SMTP id
 4fb4d7f45d1cf-6a14f288d44mr4472220a12.3.1786023421887; Thu, 06 Aug 2026
 06:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJzEm4pwK2rC=1YpA1XG3qCR5BPQ6O6oFY5=L5dDViKJN-jqbQ@mail.gmail.com>
 <20260806123212.GA1868331@shredder>
In-Reply-To: <20260806123212.GA1868331@shredder>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 6 Aug 2026 21:36:50 +0800
X-Gm-Features: AUfX_mxGew0dyWnIVJh607pRs9RO_UIjAbyWZMPJFY5tFUOeaTwgnjIooAuJZYY
Message-ID: <CAAo+4rWUpLVB=9KGfw-wz+-T_G-=1-3uOEBbGXoxhypM=X0QvQ@mail.gmail.com>
Subject: Re: [BUG] ipv4: slab-use-after-free in fib_nhc_update_mtu() -
 unlocked walk of kfree_rcu'd fib_nh_exception on NETDEV_CHANGEMTU
To: Ido Schimmel <idosch@nvidia.com>
Cc: =?UTF-8?B?7JWI64+E7ZiE?= <gomsoup@gmail.com>, dsahern@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ido,

On Thu, Aug 6, 2026 at 8:32=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> Chengfeng Ye sent a fix last week, but looks like we need v2 which
> acquires fnhe_lock for the per-entry update (while still using RCU for
> the traversal).
>
> https://lore.kernel.org/netdev/20260731162938.3388534-1-nicoyip.dev@gmail=
.com/

The v2 is just sent.
https://lore.kernel.org/netdev/20260806133309.731709-1-nicoyip.dev@gmail.co=
m/

Best regards,
Chengfeng
