Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793178912;
	b=fjlXOLEylSEqB1nnMusybmTzr1VrNCD+bLo58vTumWlOsGdzf/0+f9sJc4Pe/Ic8fT/R
	 ri4tBXOBzDf2BDQZqgGa8VHqTx8i7BqvL3zSTlGgtgo7/ebPQx0guTMta5jvpKhCO9l9U
	 oYxHMBmkPK/0QQUD7aFLTuM7riISM/K5irMMfYdhKn0Nngw4idE8SuKRvBOrji2ZkTfp4
	 QctdU+bwRuuUdFuoOosoaIKGiq6Lz1ZM9lcwM43iSRxt/ZBkm8C+/EyxUSHw2wi/92QCv
	 DU3RDocK41juOVOuOpKrkgCTCIxBT1H0WEnqULIhFzjYmWIFaoTg4u8f/K9OvzvzXKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=rgYbJL+97zD3vJtGPYNhG26BnNpkkQBqC88k+H4vZ/w=;
	b=jQXPhMxL9vhdr0lAf3sDPv8gfrYPT+FymPZYkyOZ6XdEx7ONJ0zFa5cGLLFYTeuzl5ex
	 hsLJ2rEBwYonPtDDGmHx9yZMnJhbGBbkzRjOjXmyAOygrvlC45SyMNBUSKyfjXA365YZq
	 ytUmnoHdpVy7NDAK6ZzdmkiAdmsYSGHiedU+Oa8zhfnyAhHi/TPOsTGxslfZznI/yrD6a
	 dxT74SjerrNAeVnk08ccHXwuJf7nVSnVPO/oHwA+GuywDRevmwWeP2XaJA0KiqLFi9ltu
	 IoCGdLiiPR8hc4YI5JMUC/UzC/b0CP0dXgENGVrx9GKBh+sGICDR/r3yjxN9j8Xz+yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gxj03YUP;
	arc=fail smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE803606A326
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE803606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gxj03YUP
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ad98c3fb15so5790607b3.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793178911; cv=none;
        d=google.com; s=arc-20260327;
        b=VLbuF2tsOExTLZxfBJPuAshbTFw5fC1do9jY4y1CTLxbsAKCFITtsVDfoHiHjcmJsS
         yKwakXo8/22ZJgOZlZmSvQT/yHB547x9FOIQUkEkUy05wsSFQJq+vbTT6S7UHAZCRREK
         tiSs/r9MROdn43aiAOSzEHHo86p9xQzM3R/cTqOpD7aMHcAlNhKvObRFXwOd8muD1Q2+
         td0qEqfvPlVbD60NQnUfSSOfwWleMxRkQjB0ZvK0b1GuqzaQU71tTVzcPZby9cY+Ncgd
         UyyMqHQBw+/aZZpX0cFUUYnYNI8wyINTDWe0xm5CZyOG1y7NRt8cpZEQA2qxFdjej+gk
         xdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rgYbJL+97zD3vJtGPYNhG26BnNpkkQBqC88k+H4vZ/w=;
        fh=3rM+mk4x3Nd7dZrGPPzl8nXyUwXhAg6S1dYaTlDEkdw=;
        b=SYVqzgoCtnOiM4snAJhX6D1jRNd34BXeA6Zhk2u6Id4WEZXPDlxggeBgXyZbv65eO4
         V02Oo7BOn6vVb3wOf5Mv82nEzqZsj1ed25pkpg7P/ZKFqvUa2RjO6gGRgQraXhfszkKg
         +YDofl/tmnXDM5V7A5gDCk9bie9hUhPu4LwDMUQPGbeeltG/o27/w8R5yTSq3/e6aiz0
         x+YYPnDAL7U7ScZDk4DJtSVnmuBcruJykrdZuhus2NgzHmVeZ19+dB5tYd77+3lKUWqv
         GQqBY+N39Q655WljbSbfEFvYRsX7Pan8yC8WpTjWUEIBkMAqz1vbTEg6Phih5jSc7LXe
         b2sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793178911; x=1793783711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rgYbJL+97zD3vJtGPYNhG26BnNpkkQBqC88k+H4vZ/w=;
        b=Gxj03YUPbdR/clqZg9tlNzk4d3ZlPm48KZ8974pRubp18iFQcXWVbLzGMZ6u4uYFdd
         FTdZaJlCZzMRd1mLk/YDrwMLcE0SblL89K6YM6BiDNmObL9jz/MD2c9uQEDZz5YLcjvW
         DwzFiguKXC0SaiWSEZMqmWYV6qmVmlLt82xj0Wk5TKjLybR/+9/JmQE/0ZCVdDXcpUKF
         l+Yp+AombyPUWFNEvm6A6SFEdq+BUcHsANU4HZlsfXOQQDqjcFMrDuHOI97o7rsslw0q
         kj2Yin2lv2Fcnfkfwb0pIvtEHtXVdT9/mzHt1Mazgo7inEGDfk7y0bzpJqdrtxa+qEnP
         jTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793178911; x=1793783711;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rgYbJL+97zD3vJtGPYNhG26BnNpkkQBqC88k+H4vZ/w=;
        b=tfzOYv1lc+sICzMHFyZOBLqwRHJUGLag3S2X+Vx4YWIzwGCsRvePoAVq0/imMUepOF
         9wy9oL+x8A+vamOvwkT19Z0gRuG9C21pgBqQoRRKcvE7yndE8w6IX4NMS7/YgEwrFqWz
         kCL0mrXDov4tQO7Z+cin2JzUAZHLyw9Rpx+LcUZGm2x0EW0tveDyX5TIxZRsnGdAN98E
         TXqqO6CwTy3akuDd/iROQh+PpkW5kFzaWE+/WwuWUfnASzpF+2q9bUJyngtHEgvTqUny
         xn1psVh+CJBsv7LH29GX9zHdyfaN2pZc2xJdsIDg2/NkQVsXsmftT8ISkgnrauBqK+Xi
         tSgQ==
X-Gm-Message-State: AFq9FYJZCkOZMfNuvsuUlnJFoei37tQ5C7HlUFPJfvvDTp3QBMp0f6LH
	j+kajgIUsQX6BaAjDm+Kohg7x5t3rkVhpQDB8Zr8uJTcQ1Mf3o18QHxx4/o9ovKrFh46eJAaxjV
	p9bacoIMVBDtaLlxz6/F2XWXb+BhDvrk=
X-Gm-Gg: AYBFou2cS27p8yOb+5P5dfS4TyG2UEEJvITyE++5GmEtEj1X7s8+h0ens+DlHTsm7fS
	aRvYBtb2l/0vVBJQK9XB0bAjHMmwHW8X5GspNnhdOjlS3ijEo+tSx/qCzDGgSCEgpvPAVNwBm6Z
	AVdu3VME1+mkF4+8ttHCQ7vlaZliY4FiIJITabLb38+74XAyC0dOsPqQ65fvNsYI8em4B0PjLx8
	hrmk7zyPQACxUOeZRjiy00QAyrOta7oXvsSkwpj5Wgw2djT7jqM7Zr7wv0zYTBVjESUA/WbGor+
	H+XQV5FA3xJxpE3b1O/xIviX4c6htSBubgvZUkJ3E2cwJdsZ4uRIR1WpdJZed7dEgp2wD3qDo6E
	I6f6NBev2/9EuKagTtPzdNLMQwEEfw0/1cch2hVZBogWtaujPfJaz0siBQ7Lqny+z42Y0hF2skb
	DcO60rjGbl5otatf5mDzOcYjjWjgS1Npkrwz7RifaacSbfmnM+tWZS06nZAzbGt+o6xmhEGGbn1
	bBM
X-Received: by 2002:a05:690c:d88:b0:8ae:e69d:913a with SMTP id
 00721157ae682-8b1b59e377amr15297507b3.1.1793178910901; Wed, 28 Oct 2026
 02:15:10 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027202230.3539646-1-florian.fainelli@broadcom.com> <20261027202230.3539646-3-florian.fainelli@broadcom.com>
In-Reply-To: <20261027202230.3539646-3-florian.fainelli@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 28 Oct 2026 10:14:59 +0100
X-Gm-Features: AclHuK_Bot17NYe_eBrBNcjZsY2UOe2pzR0LYlP2a1aeZoUNFbGT_vp8woGlz-c
Message-ID: <CAOiHx=nC4rkmV_F4BLXj5eNYO7VL3epYr-F3ENGmTTCtvo00sg@mail.gmail.com>
Subject: Re: [PATCH net 2/5] net: dsa: b53: fix the SRAB grant timeout check
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:22=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> b53_srab_request_grant() polls for a grant up to 20 times, but checks for
> an iteration count of five to detect a timeout. This rejects a grant
> received on the sixth poll and reports success when all 20 polls finish
> without a grant. The latter allows a register access to proceed without
> ownership of the switch resources.
>
> Check for exhaustion of all 20 iterations instead.
>
> Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch"=
)
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
