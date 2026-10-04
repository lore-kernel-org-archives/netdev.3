Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B1428506F
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791153887; cv=none; b=QW1TiDzpzGTE3K8R7GLkdOZegEsY44poey8rQLNACX3Zd5KTPshCBxflRzqOqu454qr19gK24ugr8gTkyGLg4cE376rtumKRA21LXunab3/gJL+4ph5VUoDiQPeafEBuYwklCM7H8yiTJNiG4cqTMrS+ICnII5W5O/P50Gr0ud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791153887; c=relaxed/simple;
	bh=RQrQZVvWkrjZgbQ4MZd+PC9ooU9Z249UpmAHe4qG04M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLW6yU63A4Un1HhVUYJbVjnj4U1dBO4+8mhibuGOEKnOT7EhIVeNHhmNhAQGUT0QTpJqJey3UZi5RRfTG7YNqSl3uk1GgbCW3Hxc4c5pXtqHY3Shd2qtWZfEvov3+TdOpmRqqash9MUF1R3YWmzevOcN6KgMiwvW3ZwzBSdlTw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3QuSwNE; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3QuSwNE"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b08452cafso780102f8f.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 15:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791153885; x=1791758685; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lusv9musr2ttjnYRqCBgWFai9OjQZSC81iWtocGvUX4=;
        b=X3QuSwNE0n8SLMhtQLu/Cwux/TJp0QUlJGU7lVppNu2d5R4uWdjfKTDkqnmLZAJ5ny
         AAGCXhw+MWPPw94GN9HwU9SUd2Vc75kJeRkKonPmJHjeit8dKUDXcphOdzoP2i4kCsaB
         P56369PQ8mFl05vGy8x7nshaORw3/ci9rQWJdrMFBNEzf2gJXnI+B/F66b+Ruj2oHRnH
         ubDBobnOzwXnXf5NPWmOuwzx/3TJiPgil9UOCLRlFkW8MlvENU7jZWMOhUgMsGM7PRoF
         LKLQLRWyKFAxS3ke3dw79PxndJgUvEsclY2zmgAUgl6OY+cMU9mhaTRUIF3BWMImEkSZ
         7taA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791153885; x=1791758685;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lusv9musr2ttjnYRqCBgWFai9OjQZSC81iWtocGvUX4=;
        b=slrZIYhlwnIci1Y/fLxeek+HfPxpBP/IHKFDxH0MqerFGEyl46onV7F3gwqfDlcSw0
         OFVVMcnJksbfNSb1UFdQRrDYt5mrcXgUFwPljJhWFFrG3yy5f+FkICKoSdp/MLV6/Hau
         KOO/0/pjLINuDu0aEmW344UTzrrRlab5O3YnzIbsAS8dsGHX9lw0Se1Aop1cs257QF6z
         NsKHNBR1gxMD+KnxkV7JmP08EpEfyWomIFQaQml9my8mmMPGm5zVh6iXjhckae8P8zYa
         wrmo7YNoh75Z2n4SK0Z5FgFX/JqvzeYI2nh+09z2BdeS2hLda0BSLaNenc+NSY3gK3ll
         MkJQ==
X-Gm-Message-State: AFq9FYIi7tRteBgzWMWfGsbvUBq/YD8UYRyo2Ib4V+FkaBGzYgS/Cr0p
	kiScLnHOoIyFsskJ7Up/LMeMSU69fDgV63O+7emLMmS3Cl/fTPxPx+Kk
X-Gm-Gg: AYBFou0fPx4BADL1K4Jkyt4z3ieWOujTnPmU1V3i2KSyrLAD3ff+bOdemThzAtijzJ2
	ULBEXnnlE+n3rE2qQCYcsb999Q249BB/dVrqcQJpllitGE7XeEbapzAx7pwRsONB39Z10ZBPODx
	iuHp9jSKP/Ks98+G2Rt23+H9G1qJUh8fWEFRc5pD2bcAlsSk38YGusvTLeJI716cctcb+Uum2+G
	ChRN6skZtYtwxmOunoS05Ml/7yp+TkBhseWT9717nV2UadQ68/fhq7aIV0U8zDRDJMAvcstpXWT
	OYFLu1ScZQut9gzsdOPsfN3MvxMWc3Nt90J7bQxt7MMGl5piBBWKEM415BQMpvDul8QqGXGo9mi
	u3I/MtG/TaxDsWGWNwS7dbbLgGVBD8IzoDta//aWSnunhzDtefWEOcbxkhG1acu54eda09MuLjL
	QLtRvSwGdlOY+K/Znv/UOKn26cIjpkk4rWGC4R4nTKIzf/WlHkZw7IA7SZ6tb9RtuBPpivqHMoQ
	jXg2fci
X-Received: by 2002:a05:6000:4312:b0:48b:4a2:8175 with SMTP id ffacd0b85a97d-48b12720405mr15518616f8f.43.1791153884706;
        Sun, 04 Oct 2026 15:44:44 -0700 (PDT)
Received: from [192.168.18.21] ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c57d927cdsm5985325f8f.6.2026.10.04.15.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 15:44:44 -0700 (PDT)
Message-ID: <35882765-2f65-474d-ba07-3f7642bd1329@gmail.com>
Date: Mon, 5 Oct 2026 01:44:42 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] usbnet: fix EVENT_RX_PAUSED race in
 usbnet_skb_return()
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
References: <20261004223852.312487-1-omermetekaya0@gmail.com>
 <179115379510.1402591.18007585712452116262@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
In-Reply-To: <179115379510.1402591.18007585712452116262@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/5/26 01:43, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Sashiko pointed it out.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

Theoretical.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

