Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7489A51DE16
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793191; cv=none; b=sWBLrvOpVsLzjD/sbgWV6cyMkxsEJ69u8iJ5cusXnerkf3ODTSUJCj/dwo8AVmoqb+EXgHzB9E8fWcK6wT5PA6GUR1h6Y/oRPPhmB8qvfKkeZm0U9Ja2Fo7cxNzRXGNU1TFhF/E0fodnk1GoAXelresVTO3pVQyxlWyh8nK4wE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793191; c=relaxed/simple;
	bh=e6CwLQO5sAxSsuvXcvT+jnJifanNDz9udFYjj0r+Dr4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=E9VG5UGKWCN3aL5gS372Y+AiEsWagQtJqyaAHK7cvL6IXsWzZLDEFDAwVLqQpnX1jZTbgjAHdIBLfWcd3NNXRQQ5PuyCOgqnliWTbY2dansJqVzOp8q2LfcwxUiICV6GZDYjClZVPIsD7K0Uvug1RqKETrCP8BoJawkt9M1t6eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNyQXOVl; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNyQXOVl"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aa8d882so6525619d50.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793188; x=1791397988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LdBel1HO9AhHK8/2st8azXQSt1sbQggOvJi4hQfqIhw=;
        b=aNyQXOVlEaS52aOeVggWjsQpvmMmHPzgrGJYu68f0zLk8xcHJjTWhPmF4AgsUsh55g
         g9fPWNr/S555AU5ji4G4QTLi0JbujAhGd5P+cKZJMWdPTypi35byEUftYJH6pyDwXpUR
         VYauT1hO0pVsqTzZRa9NaNcXGvUMMPdNPLVBA9SapR18jqDIOwC5Ny210frLRmiSShV2
         MG11mHhaq6pBfEwKnygluEgP8aZ6DSpw+SJ0EKQi+uoESET41tOxrfljzCN2S7Kpnyjx
         StFekD1VAKoV0/+w4Ms+fbKjgKjRLaURRgd8TIB0blLAcHOZfuMVUTwproBudNUpawo/
         zLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793188; x=1791397988;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LdBel1HO9AhHK8/2st8azXQSt1sbQggOvJi4hQfqIhw=;
        b=gGR4+PPukGXq8eWmjqYca+VLGl51cVsBa2hCZvjUiLjUv9a8VlsKvxMg/R3nIs5b29
         JVDvt6uoT3mMfB9V5puyhMq8Z9hQaND5sqmSXJK7ElDlk6EXvKeTA57QAhXdqE8N3vKp
         rcBTIeiVIF6BxkxQsEOvr5I6ghERdAjS6E2S09W6o76BsXGWggIUleJixTGStUUmPVgE
         W3ePQ/kEfUtHwmDdFy/kWU1wT0mJZrGx1wiNTULWN0MHyG3WHXwgYtDlObgOArc2AJsT
         N9rgcZDzUZcJtnzFuTzECBCg4iolgY1/oQDjq2hYsX8Y4pQpMZqvn6vZFLlpjPav4juV
         rrfw==
X-Forwarded-Encrypted: i=1; AKwUvBy8BDzg8aJyag/0ENhNK/GQ9DgtixA9fnS27TWe1J+F06uSWnqelqn1veij7BVHWdRMklCQOpo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUOvbj98FXd9RLIMqnqx56EkICYJN/13C3RTLJYHDwDb+iXyQ0
	lIq+SxDbucxaEMSqwSZOTAFPCQDZIqBmLwpSDNl1sWSqn1lYs2OEzLALiMjxBg==
X-Gm-Gg: AYBFou3mpMPGtB8esNI1fPBx71Kf2iH4YqFKzN0C1Y0FwAy0PA+IOTBpAbq1hcrjKkd
	W+1SO4Y/OEZMmUl1RNnCJUaHLZ5j7zQqJNBjmD8K1AI1LxAWGMKntq6dYzowIwTvoWaxijt46N9
	5PIcq/qG5g9Pxw/n+vFgSTQKsojFDpdFNBXS1HsJ1z3/JcDjkb53/wn0dedlq5v/KJyUzrQVZtQ
	vb2m0lA7JuMT3X9EHlnF3g11kGvHuDxgXI447+teNnspWhiB8WFmfHUHd66YQi1bSaKcTXClYr6
	OgpaiY8tN3+TVDPdzRjmgNSUdMiVfQ9soqx6SqbI56osriqqyWjSP3a3TERjTn8J6NahZOZ7YkL
	Px5Ae80J0HPqFfyor0qTtixLUZXJAFkX4pchnOGm3Gn6G4MNxVA/PAl5CNAKBwZdZttMsxJFLCW
	Vp7jxpr69AbvzjV67QKBfyG1RtopG4IjeBlne1nuGho+EXD4aEYgcsVV9t5yyzi8eao8G0ucXKD
	g+QEzMRuVHSdm9zXbMSZ9XsSdwKOO9JSl1mtE/PAmslZXTmM2vl
X-Received: by 2002:a05:690e:43c7:b0:671:1c5e:9887 with SMTP id 956f58d0204a3-676835148ffmr754430d50.68.1790793187988;
        Wed, 30 Sep 2026 11:33:07 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67691838960sm150461d50.9.2026.09.30.11.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:33:07 -0700 (PDT)
Date: Wed, 30 Sep 2026 14:33:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rongguang Wei <clementwei90@163.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 Rongguang Wei <weirongguang@kylinos.cn>
Message-ID: <willemdebruijn.kernel.3adc274631629@gmail.com>
In-Reply-To: <20260930080746.135017-2-clementwei90@163.com>
References: <20260930080746.135017-1-clementwei90@163.com>
 <20260930080746.135017-2-clementwei90@163.com>
Subject: Re: [PATCH net v3 1/3] tun: keep a kernel copy of the socket filter
 program
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> TUNATTACHFILTER copies only the sock_fprog header, so tun->fprog.filter
> stays a pointer into the address space of the process that issued the
> ioctl. tun_attach() reads it again whenever a queue is attached to the
> persistent device later on: unmapped there, the attach fails with -EFAULT;
> mapped, whatever bytes it holds become the filter of the new queue.
> 
> Keep the program in the kernel instead. tun->fprog_kern holds the
> instructions and each queue gets its own program, built with
> sk_attach_filter_kern().
> 
> sk_attach_filter_kern() reads no user buffer and attaches the program like
> sk_attach_filter() does. The caller must hold the socket lock. Failing the
> attach releases it; so does the socket when the filter is replaced,
> detached or the socket goes away.
> 
> The copy is freed when the filter is detached or replaced and with the
> device, and tun->fprog is left untouched so TUNGETFILTER keeps its uapi
> behaviour.
> 
> Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
> Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> +int sk_attach_filter_kern(struct sock_fprog_kern *fprog, struct sock *sk)
> +{
> +	struct bpf_prog *prog;
> +	int err;
> +
> +	if (sock_flag(sk, SOCK_FILTER_LOCKED))
> +		return -EPERM;
> +
> +	err = bpf_prog_create(&prog, fprog);

Interesting small issue, not new with this patch:

The BPF program is not validated on copy_from_user, but on attach,
possibly after the system call has already returned with success.
Which results in a dev without filter, rather than a failed syscall.

> +	if (err)
> +		return err;
> +
> +	err = __sk_attach_prog(prog, sk);
> +	if (err < 0) {
> +		__bpf_prog_release(prog);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(sk_attach_filter_kern);
> +
>  int sk_reuseport_attach_filter(struct sock_fprog *fprog, struct sock *sk)
>  {
>  	struct bpf_prog *prog = __get_filter(fprog, sk);
> -- 
> 2.25.1
> 
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus
> 


