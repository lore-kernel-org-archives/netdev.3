Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.221.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794524660;
	b=3Sc6T1RAIQpswzA4BfVF895sDbm15tR5dw61v0Fkets4ZCpegeP3DPhoM053j21dW6fi
	 HW6nPp4XEMU9ZfsKSU9lLkzmax+vZun8B+4PWyXf6Quz7hlvQIVsgqsnC16sRxOfxk3eP
	 k3KS8cgEpemuFK6Dliy6AyhT9KKwjU3ksz0HWZewxSCStTGWOjEq7tVAjRYj1bEBrJYBI
	 zIjh9tH6G7PAsFMA6VV2WE1z/134+UfakrW8L3v97vIkkVpFjTw0m1rvO9IkumiVl54eo
	 Wbv5+J75vqRZYGt9n5supWX4UWlm7kXA9gvc8Sc4n8moIazov/4y8417ll8MuNhzpLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=08MDudRooDplOYZuxvUS0XwmDlBnmweFEYBeZu/K8vU=;
	b=ySHeh+n7W+7ONLqhsHWiFAD1juWS3BgwjWt5d5pLYysGuOyrLeZq6aRqtov8j7K19G9T
	 Idej9WLF48DQOT6uQTmGWKKYcSsrBZQKUymUIbY5if4JdhXse07+PVtXQ7BMRn+FtWdZ8
	 f5CEopyniwZfJuV1It5WqJsbqRY1NnyF92CwTWG2s8Bu6+WG9JZzZ49DxRstsQIPC6rGc
	 DCPAH9d5hQOukxG4rr5vdEHFrZ70+60KL4ye4KtTAb/xHeVsjF/X0a8zOBW/yNTDdhghr
	 HSFgqGLWSyxyvRVZ3MkwIcd+n5VBfT0Ux6rbcW7Cgwsx13ytf0jCEG951DaIglYkyYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=YEuX+fX5;
	arc=fail smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4221F606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4221F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=YEuX+fX5
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so503741e0c.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:04:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794524658; cv=none;
        d=google.com; s=arc-20260327;
        b=Pfs+Y99koEnUOHPkDRps2iL6TRMTx4kAENlQXDspl6vVMkwuj9FP3+c6avc/7+r6eT
         oxWkpTH9owyCTq2+RxM0X9Xhi9pGF+u+Yuyox2+KAzN7Y9mFuGi+n3DMFt1mUdyAza2y
         oh0chQEK2dZPxhuTFfurvt9GnvKHlTxhvBUy5jZXnpHJVvPR0V2DsJL2u8HdlPdySKek
         PoBk+aedUv8VUouVYR44SFOt/zKdMnJpuEFpClnkACsuSZzdTHeFSdAR5fqBkuV+u4oY
         qwc9eCW1wgrogqP09ee6J4rJTWpET4eA73Z1inafDe+K5Rbmu3Wza6bxmlBXaHNp2yB7
         0q0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=08MDudRooDplOYZuxvUS0XwmDlBnmweFEYBeZu/K8vU=;
        fh=hYHrHl29J/u0XQCTXgnmGqX69C+sLUSa5c2/eCdCTJ8=;
        b=i8EE//D0ipKwTU7J3c+d43LnC1ekGeFR8n+f2590c/cT6+Ab41aBPyzt0N5xZjhFBB
         nI8SCvFeROWgrnTltx+zl8lFYIoQ9y2nD2l90IVHWHBAix+aGV/ND74fuZ65TO4K/QGE
         i5VXZkIu8jzbjwY5QwDEFRgnZ9ltv6juNWCtN7YuabYuoFxZN+WnMsTqs81AbDrtVpYW
         uDFc43nfpmKlIdC3jnCNZH+kSC13kdP9KTUUpL9lMmvoE5Rq2zvBHmIK+/OmS4v6i/Lx
         vsP+4Mz2t4WuNCAAEXxLJ9KgF6UBpCSJgWYJ5gcquM4pA67iqOCsax+Nv8S/nbsKEWaw
         piSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1794524658; x=1795129458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=08MDudRooDplOYZuxvUS0XwmDlBnmweFEYBeZu/K8vU=;
        b=YEuX+fX5PVk+ImDaWF906WZy8L87NhbtVg9P43fmC2fewvrznUnbo63wuRLcy59skh
         GnRGKrbyGMz2w/B9lWL9UatD76ON/1KxM2SwCDMcioMTi6MNw5Eb2Wc9v8T/z6fgrIB1
         dvi3Ze6/Q1bIbPMCoQp3ukySEtx7HwxWZsI+gHk9izaRgjvZQvfYAunAsM3L1neAFMuK
         DQ2XXlgNRvgp5N8UaJZk6uUhqBlL2qb2CoOPPXZq6dEj4MQlo4VDdBqosBvbVEfV/GQD
         Y7LbTvm5kcgeC1iQCyQ9Lxlr7GOvxUouAI/iSUf52rUG7Q0W/y6AO1r+iSC93n+cvcoQ
         gcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794524658; x=1795129458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08MDudRooDplOYZuxvUS0XwmDlBnmweFEYBeZu/K8vU=;
        b=CB5QnM+dYcxRDFK1az8iLhLjCOl8slbF3tCzz5QbWb3zFi+b+Bk7KNB+IqG2ov2MgH
         I9C04q6AVz09frm9NFup/JNXJqEWigI1wqMAYuSa16kcePIzlDwvxvYLsTFlrPFxH3Ud
         5p6s/8XEBkLkMyj0ZQWwFYTqGaLLSDs11g1Yu/SgvpbYOl514LxPSPUpB6Pkp1XBZTLU
         0qggBLjmKSo/Hc0ZYfs34Vav+Qr22XetGf8yIA1nr0Mxy+Qs5FaHn9uxAM+J/pmKPbd7
         6FX3DKMGIMiN8eBYWSHNIyDOWRGP9JfsnSfKwTxTKT7Tvarlw8WTF9bmhqn/OULtyglF
         zP/Q==
X-Gm-Message-State: APuU4Z/3AGIv60Ik6/G2Nog0Vvrq5LYlqQk8EeMD4tVHAOPjhXvPfj33
	gWzooDBZ0txyXQJ7yO13nyG8tYIBoig1LF1E9WrKvH5kWsrzzvJ+p/zAYsL2QtNCAsW8GyeoWWF
	JgEeU9/DMeNOadvhSX8aCFsEvPztES4dgE2xWxIKShA==
X-Gm-Gg: AYBFou2qWeVxu6ak4Y+7HxWDVGZHnmPu2ol4hmTErP1KmYe33aAAcsvxvPADp/56o+8
	GYnjQW9cQq3EIERA3C7HVSGtZFxrgRR4Zrvt0bQGIGgBsJuQLmbkSvO2atnKZtyx2lpAuSpS2M+
	CqEsMrzpmAUktjtxAlF0+2vySqcppi/PN9IKW9+t8qpsPpFpK7S8kOcflytAY6kIVkHuhM4Oh+f
	bKgJxGJI4SR7bSRot6kB7p1UFhGLrsI0lKkuQuR8zPWviN/m+iEPuJnqUtk8kIxyBg5G+lIE2yG
	OnQaRKL40k3QOOYWvr4Xh6NxJCSb5XYT44rJLeQEvlrosJTZ5yE+QvAVfAdMdJmq0z9sb2JTS9u
	zvix+1zz2mQuK0B08wmF1O2AFBsejFxJbhXgOedsFeAzaHU8q6UNk6UK9h+dhJAWW0+XfwYjZkj
	62H0KwmCCus0UiavisAGrszExjD6LSF5Is8qt8AE3esgG5IJQjUl7pbTdUGvh+5QYl3LI1bGiSl
	1awk9/n8YxGbW0JmjZGOYLZBewSMxpucxoQeZFEN1m4IHE=
X-Received: by 2002:a05:6122:6849:20b0:5ed:c029:411d with SMTP id
 71dfb90a1353d-5ee274efedcmr1175996e0c.19.1794524658165; Thu, 12 Nov 2026
 15:04:18 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104183442.617519-1-rjethwani@purestorage.com> <20261110131222.7e228d44@kernel.org>
In-Reply-To: <20261110131222.7e228d44@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Thu, 12 Nov 2026 15:04:06 -0800
X-Gm-Features: AclHuK9qUUhccz7x5a5PPsAmZt6NNNYClixwKS7-w6C5DGK3uR7rry1APfVSnPE
Message-ID: <CAKaoeS0KoGs9mZZZngwh97+8VgphrRxnHdGr-XmKUzmVp4AK6w@mail.gmail.com>
Subject: Re: [PATCH net v6] kcm: reject attaching sockets with a ULP, and TLS
 on KCM sockets
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, syzbot@syzkaller.appspotmail.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 1:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed,  4 Nov 2026 11:34:42 -0700 Rishikesh Jethwani wrote:
> > Holding a ULP also has visible side effects: getsockopt(TCP_ULP)
>
> This part does not feel right to me. It's not a real ULP yet we will
> start announcing it via all the ULP uAPI.
>
> If you repost please try to trim the commit message and the
> documentation slop.

Agreed. I'll replace the dummy ULP with a bool in struct tcp_sock
under IS_ENABLED(CONFIG_AF_KCM).
KCM sets it on attach and clears it on detach; tls_init() checks it
under the same socket lock.
KCM still rejects an existing ULP, without appearing in the ULP UAPI.

I'll also trim the commit message and documentation.

> --
> pw-bot: cr
