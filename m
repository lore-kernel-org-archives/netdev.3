Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561484E1C8B
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062917; cv=pass; b=LTL7tMHzFpHssQ6Sm+hqCirEKG1PDMujlXi4Lzyaa6dwHbKzuCYVsD+gSRXE32xtAZiB4+3vkq6wyRY/rzNQUOiK7y0DjgBr9Yd/GUlHlHBtDtLYkntVWXeaAAbqvWZ/AhYXms6heku5Rj7p9/iOHE3D1dpvU9nWiIQGwshCU1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062917; c=relaxed/simple;
	bh=I9oPJ3YGlwxlNX6cpMBiC5ATHr477eWduZeRhnHEaoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuYpBNor4JacAHGnqFjovOno3isvuwY4GWObIP0Uzf1DLpPg4GqIRLoZv3inrUvFUFNVPkReTe6ZjQbavpAQGRxLRzxV2DxmxGBEJXPmBn2XE2v6O2lqERRQ9lvYkyVNbgYqhkPogPlS3rACF5XwPPKDV8fWMUqKj0Ga2GguaiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=tFsok8Gu; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="tFsok8Gu"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ab37e44643so15275967b3.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 04:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792062915; cv=none;
        d=google.com; s=arc-20260327;
        b=ItHXbP18EYA4bNkFclK6VEbhxI7Kv5YARSXijIfhKVzN4mqjWVKbcg1ZjmRWCneYRV
         W3yw7K+Al3y91qhcI5b+2iV1kGNkg5oj81AvsMR6xPhzuytmVCWQhyWQG5DVT/5uVbW4
         o8F9BMcs3pETTKKsWNBwdSV+3S34vJ1PwN+8brX3pPCIMslWi/dFCwWrtsuu6QzbUqyp
         PXRYJLBqvv4sTk0NW/rcSLqms8qqmVbbjNMMS7wKbnShyu7gR5bAY2gk+HrGztqDvpOm
         +E3dpw3/KRvi+FAfdgOoxB2PLNolwcjolAGz3Eq7OmZM0/CpDa2IHaU6J1lxVsc1BR/9
         pyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I9oPJ3YGlwxlNX6cpMBiC5ATHr477eWduZeRhnHEaoM=;
        fh=iGJn1tAz80iDMoYKRDnRRwfrUjUtriZiEtJd2gTKNzw=;
        b=VPXiOkilrykOLag+ciVV92j32ODmyA0l9YrZctiGTJoMU68Rfr+Ck59TJWfgWBm73G
         jxEOfhTa76XGK4ZjwUAaMlFSkGx95RRXuecKYFrANi+jCK+UHZL5knDL+KTo+nQSvu5K
         Ri1fv+BITP4Xbtn+cWDeGMEJ9pTGOywrQuk/15b9X99ow+x3BfA5LSaiKPsSlKraNy/7
         tipEb/Kh9HJPkewdFwOOmIuWF3VMQF4+dmk0nEozu33AyTP3NgFFdEfyPe6UhQ0eaP/U
         x+rqV+G5mBQXOWFxddiH/wz8lAu/i5S9R/uwg9IINAQ4xMMMi3NX/2pYHK1gOGYTTPH5
         mSAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792062915; x=1792667715; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I9oPJ3YGlwxlNX6cpMBiC5ATHr477eWduZeRhnHEaoM=;
        b=tFsok8Gu7pL10k+toUtA9U1xyWr1fKGTQGuD6siZNufYDmTlx5iGEacoYxtaO/9xuZ
         royzZQvQ6BThJfyJOQm1cjOvW32PR3hZrFJznN27ptUm1mghkbkPzgXvj2a6XHJP47TB
         bbih8OPOOMxnSjvYa3885JLpMvx+GgzIpy01s33Pr+h1OnjbITbetlHEid5It9BuxJdj
         +jtrJxAEb7mGxUwzI9gbGyCk7bauz2wHkzrmnfBsZ71s8dxlipqI21+C75FkHWcs/1y6
         QR+IKe4BLpXExBmfQlhIMoF33/KjpN4sl9hVB1ojQGf4RCv8Q7kgUbMcMuO8dLhZMhMI
         Fxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062915; x=1792667715;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I9oPJ3YGlwxlNX6cpMBiC5ATHr477eWduZeRhnHEaoM=;
        b=WcEpveyoRqwdYq189Z7nXs1GdJVvoT88cRvpiYoBT9RtPcJ2pbQpW0BGwPXb+sPsKi
         NqMFVU7YH3dZvNWmtNdD1+sTS3/qY2/VbaDfoAMCwIcEtnwVJfkZgpMg3AVhxPBHwQTI
         Bh7psQYWFXINkCTHkQGX5CUgvmG12ttptWP3IRmcaOZnCRQSIKj2vvK/ZJkyWZgPiGsa
         YoXJzla5WC79TBGZzKBFvn3TdxscHwi3xhbetabTghwZkKDF0MlE5OFcHFinPnJ/Tpzj
         fnitL2gkiGHQmFv6AqOu5jjs8NiiCyuDm7wJlI9FNFKLLUab0vZu1iGz5LDzxqT3mhcM
         cbww==
X-Forwarded-Encrypted: i=1; AKwUvBzLHDeEo8OYmZcovB6PIquqPuDJSKIEEEmKBVfEh/VxBIZ0bcsEd1vyo1EtbLITjtkUXRTXSQ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmoiOM6ryqfqASSXKVh/hPuWullH9s3MM07/DJyT+maZvy33wq
	d9iiJMDf8E6McuyKadYvxc32pIe3yEVpM+Nabvf33BJCVynp//SfSHHFJMnTiwnsML7xVRnKMfC
	yIEz5nVJbHpC2XWC8zJvQYRCjlg2Cj2ieLEUNZgBd
X-Gm-Gg: AYBFou3PUtu0e3v4q5CceiALgkhsrshQJOZkem3xF9T19+r73XX6l1frYwhhN5tNa79
	FSgEaircjn0Q1LSRlhEzr2Ti4FdgEUcYTARbhOAdvrBxCUKRCJKSpykDBojKrTX7oxFFKOu/9DX
	7vi7GmH0dhyouxued/QzrdCZqi2AR0N8V4ChN7kabqxBRid7B8fz0Df3Nx07T3bsxkTH2RJo1c1
	yEOjxo6x6vhAf5B/+NGrba87AqxDnI9/z0GMKfmbsvji/Swcc56luRDTULW5AJcQwy7D2J4Qu5U
	osnYoHvtpcSjXKcONjcwLLknwRXdNGgIw7JYWvHc36SdEB5tCPFzLJQb6oFplisUWehp28XUeyl
	ubCY0HkcaBWoMvmh5lOv5QHxDk3ahZdD/UUys2fL9orw/gTk/a/20+pQ9TQNWm3soYnGGa0IEm5
	ekH3MlrpdyZyavx+2rGis/SjsE+3SD1+3i8RhgJGeehpsb8kME1sJGZEJrvFdZ51S5ALMLD5E8O
	MiSyMgW4nzvzYMY2rS+6MmMqx0SM9awIhrpxZMTZ++QiL0p4XyDz9fS/JhusH8/nfO7fVn3wVP8
	/N6P+DwERd4Atw==
X-Received: by 2002:a05:690c:7012:b0:8b0:cf3d:7b35 with SMTP id
 00721157ae682-8b0cf3d7ea6mr10078397b3.15.1792062915195; Thu, 15 Oct 2026
 04:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014235628.197976-1-julius@bairaktaris.de>
 <20261014235628.197976-2-julius@bairaktaris.de> <atCsGx2IRecQNK3r@chamomile> <atCs-U_AXIyvvpKd@chamomile>
In-Reply-To: <atCs-U_AXIyvvpKd@chamomile>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Thu, 15 Oct 2026 11:14:38 +0000
X-Gm-Features: AclHuK-GCm2OH3Jid7zEvImtoqSM3gq7UTcC3JLFEhmei75CLrzAl8zOZjCyOVw
Message-ID: <CAC1t37+g_5q2NbKmCkxhZthdHYabypyDZSoshwgAUVjbGm0NsQ@mail.gmail.com>
Subject: Re: [PATCH nf-next v7 1/2] netfilter: flowtable: tear down direct
 xmit flows when the fdb entry moves
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, fw@strlen.de, kadlec@netfilter.org, 
	phil@nwl.cc, horms@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, razor@blackwall.org, 
	idosch@nvidia.com, ericwouds@gmail.com, dqfext@gmail.com, 
	netdev@vger.kernel.org, coreteam@netfilter.org, 
	linux-kselftest@vger.kernel.org, bridge@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Pablo,

Thanks for looking over this.

I will incorporate your feedback and send out v8 + explanations for
the questions Saturday.

Julius
