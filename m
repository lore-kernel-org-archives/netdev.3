Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F62483BD3
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782769; cv=pass; b=kr4EXQn3pD3A7yZyqZuaKxUk2+hGEHb3B2HbpEMOldG1XTcKFRIwoJASKffBYD8dcycRRckTRRY/C01kgJe4ukwgrV91e2FzX57eOFhESXmIEzab/OU3dWHbdhyxpKXx/6WzQIXnbjmLVYyoEvRN5DqQenJYbTchKWS4S5C+11I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782769; c=relaxed/simple;
	bh=HhprkWnzm5aZiGMD+GyLSsyNyk0pGLWTcDgmWY/eXjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZXLUjVvBy1ILzSZbFEVRrvVRf363elqQWEe+me1GIlpxMiTvK7+xIMZp3h0qjnhpgHfE51npQMzYpqLspQBf/TYL1DZMxo8WqPgjmXEAAxY6+LNxs0WsmzM4ZGt9E68z67wFmiWppC9lfBdpuQpRfmUatOnt9GkbidDiDuvO38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxNT5QpY; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxNT5QpY"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8557c3f270eso1630702b3a.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 05:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788782767; cv=none;
        d=google.com; s=arc-20260327;
        b=H6YnJ6r5bd4SfpSsJlBZ5bY4yhZ+jue5zoBysl5kLkoMdxsKBQV/pUwK+9WifLhx43
         sVaTQAmEnuI3HpdZSsHfqJZHCu9nxm9QfjmdRp532/8XvQcO5FkfUSmsuWI2ZDyhlKrg
         Y8DGxioT08TZcb+NFXk4LA8Yo8o9Gqk8vvUFYtTQuUKYSV96C12xk8YSVJso6LauL8h4
         N0uJy15EAnpRoVSftHLnKbf450BunWP6uzQ9Zb1Rv1R2y+0bWizwgJHZcG6vsCGAujKM
         /+oxb36NYiqCWRrqirN7+cjKHNlyygZRie1HYSB5cUJfBHts+AS3i5TWxK4ZgAENAQO6
         j+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HhprkWnzm5aZiGMD+GyLSsyNyk0pGLWTcDgmWY/eXjY=;
        fh=q0LNdNRJzlveklUvzp3WnGSk9BT1OD2YCQcUS0me2gM=;
        b=LfK7VO+QmBn3gvn3lHMZqLHq6bZHoMwfY5ucqQtB0z599SMuWP0jEQgUmf7xJ8xfN2
         L9MLSOBNOuhbpEP/pXyBBHItOc1yuoiMsmXNDXwJEyzzsx406D8EgZHR1ogAKY8XYozH
         y/xfN3kCdAGjnWm9aC8Kgzf6n3Hh5sXCrbi4tkUubWFCzelaT0syO4y7kLHpMO4DbsxW
         pMbDB5UMOBkO771AuSYI5ay0KakhzHn/xDMq21HLzvR1obTweitJV7wgSjyW++I1vQaA
         +Qli99a2AciytEA2vl2r49CyhXVGfYE0K0bOmSzmbxKZfj5iUGQDy8rIcWLCDKpN41E7
         F4Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782767; x=1789387567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HhprkWnzm5aZiGMD+GyLSsyNyk0pGLWTcDgmWY/eXjY=;
        b=fxNT5QpYexlIL22aDz3shdSqdSZS8CWn+2qNZe26Aqij3+N3Jg9X8Un+Ah0MhJUI4r
         YePPyUHDxzoCgfycSH7FyGkT7X/VFK1bWLP2HO4k0CDGG4mHswDxmqbO6ips7h/0vKfj
         2KiH7/nNn0hm+5ZEf9vzDheBsSN6epTSTToeI3MJ1C+onSCWBnkbV9VFCYOH9U1vM3tu
         tF1iLs7pUR047s/9qzSbz1fZGU47T9x7G32MIxVSfy+DhATeNlElAAi1vOpP5zj0+0iS
         AVXcyIRVgpYaagmQlxk2taQrEZkvMg3+mLkqn934TcVLMlqDbYiOGo4hooq3ac9oHT8T
         P0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782767; x=1789387567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HhprkWnzm5aZiGMD+GyLSsyNyk0pGLWTcDgmWY/eXjY=;
        b=YiDUqXdCUoNZtK4+GCY7pdlfeBWi5oC9oxuUzHUQvlXvfeY7hXT59njYbS+pMG1FDZ
         G5iQQXXOTIdpJag4bcr7/olmh8ndJ4t8hceeEamGhlWaE9oGlEmFUIE+wVz+TZj/PQTc
         0wNy8VQ26pOYLpcNM4iqRNAO5ukBSPS2B+lyI3hVbiNUQC38KVQmIaCKrISYsGzXTH1E
         qHo0GVimsAyOGZ5SP/T5hle7+b+BWDLRhgkf+rXSMpsd/5J5K7QVxe2yqIWbPSzFycAr
         x+NzwHZopWz6EvUxKRpZ7FXe5eCKkkHaGLXhpMJWUnKUvdZzrkjV/3nZ8MCzzuayaQZa
         B7yA==
X-Forwarded-Encrypted: i=1; AKwUvBxj3qk41RrVp8mKPMIglNy1MaB6E9pHnXaSKDiTm7RUvxV/Zv7R7q/7GaShIH0TMoAKhhEegUo=@vger.kernel.org
X-Gm-Message-State: AFuF++m9hQ6uunX5dj3/oUNwnZKDaAffD/1ywNNVEU0sKCuE0zw0kS9v
	qm5ywtExEhrvVm4nuZGhooEHFBcIYZQ2JO3wvQYdzA99nNfrpqpCWSqyvdZAn9sNc/qu5EUqBpc
	SYf+b+MZR+NQkXy9N7NhNXPivlNfwOVU=
X-Gm-Gg: AYBFou23SZpvQUGPkKsgWb5C0mt8ilIqmpkE08QpRULnD+r0CSMs2+3dn+zoSv6TmEM
	crImRiIHCFJePGFlC/1Ntx0rjv0dkTTMRh9cyNcoJnwjY5H85pkXjA3FCMgJpdZcI/Mu6Y90w5g
	El2MKMreUzkpjq023kfEMb7b0KBh6K5J7+WWDILSTUbXrJYHPA2RxVRoTmO6+U/VibXaEdR/8Co
	0p9CIOxhS4Q7H/HygQjvXyDcykF4YZkMtAk1rLfWTPHtZ96PzL+M5MVT7s/s3nh3u99RRp6wPOp
	L53rh8I0FKGhEyAtYhLdl+SOviFEKySqTGnNAgrdSymgb2DMEeEeBplQTwF/MZQCd5QNPhyOUwO
	Z8Nfw0MnF5iTiAYDQ+GwWh/Mf9mmzy9J2Z3OKXpXVkfqOIMAF150Azywk
X-Received: by 2002:a05:6a00:4c15:b0:848:46a0:3d74 with SMTP id
 d2e1a72fcca58-86169b6b588mr27969662b3a.9.1788782766620; Mon, 07 Sep 2026
 05:06:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907034502.12619-1-phucduc.bui@gmail.com> <GV2PR04MB11739E45D1562C9063E05D77788B22@GV2PR04MB11739.eurprd04.prod.outlook.com>
In-Reply-To: <GV2PR04MB11739E45D1562C9063E05D77788B22@GV2PR04MB11739.eurprd04.prod.outlook.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 7 Sep 2026 19:05:52 +0700
X-Gm-Features: AcwNN1VgFt55b8C2DAXKx-uTJk3d_l7pJsW4Kx0oozTChu1fJXNM2fyLx2t5bvA
Message-ID: <CAABR9nEHY+A3y52GmozKTQnot1RcCRZVV-Js5eyt7CQsb3JZjw@mail.gmail.com>
Subject: Re: [PATCH net v4] net: fec: Propagate PTP initialization errors
To: Wei Fang <wei.fang@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	"davem@davemloft.net" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Stephen Boyd <swboyd@chromium.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wei,

Thanks for the review.

> This part is unrelated to PTP and inconsistent with the subject, it shoul=
d be
> added to a separate patch.
>

I=E2=80=99ll split this out into a separate patch and send it shortly.

Best regards,
Phuc
