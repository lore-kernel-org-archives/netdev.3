Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368695;
	b=g1vlQzE7LbaGKNUCAyKyqyRpa5CDZgvxZ5yMvA/C0+RZzJefVMD/uYRkVhWoXwG7jaYm
	 C6ebw6ucN9tOvXINGVYDbb25As4/BWeQ4EvSxEYRPPLli3Gcwkdg1tgshS0AaemPxKtYl
	 qZ7OtJt5Ev2ULbIUx13m8PoR/OfmKBYh/6mfXTQu32ka3MRg3j6aOOConLjQVUX4nzpoz
	 YRDgGGXQ3AWMEY75uUzyP+YkPdcux8aAc5USdLYMXMi3J3CnrB515l1Bou9jg38AhRL0k
	 r5bM+li6onW36BJiLILZqIUTs7ewo33s/WjIs4G/JezYmFgh7WoS2cyDOgsDs4Tn8+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FvM3i9oJggLF/0zM+j9Mgv4JThMqTDYyofjEp6i1BaE=;
	b=Zu7Y12IdrVt55QWfYqjX17xdrMxfWi5cSPkP1tZxgG1WtGAfWuFWp8DbAoSL74PknxOR
	 MFWZHrwlqXsCEgzELLKTWjZ6KKkVLkKE6l1hG/JZ4i+R51hgIC7QatusIJl0TwDzErZZP
	 OFY7vTNYEY+Gl+8bjb+YEWHIJUO7yL4ewC3kfgvpu6729rhGyiCnLWbDmlK1UUebkbb7q
	 FGVS/5F3cwswJTlSslG+VFEVWdgOrsr27Nlxt9mBF72SFwn2JnvkwJemV5pfyn+wXvlGb
	 wjQGJ7Ujih6Jk1QVqXcsLKLt6r4v+oEDUTS8dF5YNYoCmenT6erdVxoIF7ymnfr0O0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GziDWtFo;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F33A606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 13:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F33A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GziDWtFo
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eafaeb8684so230633e0c.3
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 06:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793368694; x=1793973494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FvM3i9oJggLF/0zM+j9Mgv4JThMqTDYyofjEp6i1BaE=;
        b=GziDWtFo9OIuAHIXdmmf/xoVkLmKXeWVFjSfY0C3w6Hyg0+3zcC6MgmjY+hdIgajXB
         o19bf6HcHWw6aOCl7upKjKfiBofa44OMJ/TvLLcuuTuNW9aucLV1UQz1xdQCwQEjZkGo
         QQAF06J1NGdkGg27pn+CsdOd2QX5Rxvb9xqGXDSATi9y+NkxiN8i1mfJEQ+Gb2C54TC9
         1VThYUtHay7MsVgvMjGYXeKob7Bl7/oS95vLOI7KG8KxiY3WSp18/reoDpT33rv1AXeQ
         9viTfWmg7Q1qAiHl/m/g6NPUWseTZYmJQvDJsAq+GY3mTcNqcPvdjrlJZ2pZgDOOv2AD
         5Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368694; x=1793973494;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FvM3i9oJggLF/0zM+j9Mgv4JThMqTDYyofjEp6i1BaE=;
        b=ArkZYzHxCDv75G4FIuY4nPNx5nkECS0RFQ+CYorIXk62Lt8wNjLwhBJ+FJ20HnqVoP
         pUZnqcfe7OeJ96ScUNkGU+JscWJNIH+28NgpgIjyXjYXjr7ZxyFQv3qDkJ6OmlJuS0d+
         5mB6ZIauMyVI1DdjpD2foKb3XKTh9NWNS/zZm3IZXVj69vm6Kg2k/IrHLZJIX06SDQ6I
         9Q2wH2kgs0eCHAsAPyxj86Z5ybrAb35sxAIemuIQlUnJPRZaav0Js+p3UFN+fVmeG4pF
         0X8/5qPVZK4TDvSJE9kowcUgjYYuAjSPkzjcMg2ML+BEfLaaCK63oBUZCjHbce3yRc+L
         CZxA==
X-Forwarded-Encrypted: i=1; AKwUvBzc+zCsjoxVRy3lqabVcHreJEKMA5RsuzvHIF4j7C+nwLS6hWxcopdWvt7/cXWE7lMpi3yqDjk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2QbELrTcQV1KJ/couALMQ+A7G9ig2CF22Xyr3Ehl4Q0YvLuk2
	NUnhh/cQbHq5hqxMaKMpmr5qaAX2rXxbelNnQjO+PM+4+Yqv4C3ZPzJl
X-Gm-Gg: AYBFou18cTX9IkizVWAJj2MhMjEwuML4QW90iP+ish85pTGdpmiRGCLcXgrV8PS++rb
	gOokKKoxv1w9Tr2yUQC7d+/4Hqe1iXuRu0QZIzWjNq7CB2YwJFQJ49QrIjeBU9pWOJOVJ3vhgnb
	kUgduTCbOjJtkapOy5lAor+EwxhYXI8RYmk2kEqHcwds00x4mHd2CHenQu6ZowDonjYzS0nzf71
	4/mrNFT45ID4CV+agNMD8Wy/bebebOnYb6UhZBQnjbgFdGRluuALsNPX4TcFf1jORdHHICMQrR1
	dLLCgog4B+GsDAFVw+EgonHpG7JqaQTzDjkIcdXXnOdbBnZKovW0ujZ5D74e8uc7mQzdxmn0wIq
	7mMFGZr/v3zszQeXJmyLUyx74M0hhW4SvjijdQfPfSx5uyN7aA9naIE831o0bBqZfRz58vQ70jL
	mrUzhrDApk6w2tGSqk6VrppB1iU3w/jIIdYNEvv4itE4eTtUvJdg9hAlldOaDCr1eBXlYjV86hn
	jWCVB7+uaJGEnERtclaiNRDm5QQzNZP4B+wux6QmeNLzG8Kuh+dRehFq49ObbrkcDoMASGeSw9i
	uTLslKE2BE9wQutEm8zKxi41smL6X29NN8J1JaGfHMImCIQOmDeWZlQxd+D07bO+3MuEtLhTBjK
	M+pYst49sIwgCcarSKltYWskYiVw0URl1vTTqfMUmAj1TQyFbmqXRoBuErBLPa+zlgudhWQ==
X-Received: by 2002:a05:6123:12d:b0:5ea:c382:af67 with SMTP id 71dfb90a1353d-5ec6882df59mr1136072e0c.13.1793368694100;
        Fri, 30 Oct 2026 06:58:14 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bf220esm2319190e0c.7.2026.10.30.06.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:58:13 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:58:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rongguang Wei <clementwei90@163.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 Rongguang Wei <weirongguang@kylinos.cn>
Message-ID: <willemdebruijn.kernel.f2fb738aa85b@gmail.com>
In-Reply-To: <20261030060043.94719-3-clementwei90@163.com>
References: <20261030060043.94719-1-clementwei90@163.com>
 <20261030060043.94719-3-clementwei90@163.com>
Subject: Re: [PATCH net v9 2/2] selftests: net: add TAP socket filter attach
 tests
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> reattach_filter_without_user_buffer() attaches a filter, makes the buffer
> the program was copied from unreadable, detaches the queue and attaches it
> again. It then attaches a second queue from a fresh socket, which starts
> without a filter of its own, so a clear IFF_NOFILTER shows that the filter
> was installed again from the kernel copy.
> 
> attach_filter_bad_len_keeps_program() checks that a TUNATTACHFILTER with a
> bad length leaves the installed program and the filter state that
> TUNGETIFF reports alone, and that a queue attached afterwards still gets
> the filter.  attach_filter_bad_prog_keeps_program() refuses a program with
> a valid length and instructions that bpf_check_classic() rejects, and
> checks the same properties: the filter state on the queue, and a queue
> attached afterwards still gets the saved program.
> 
> attach_filter_nofilter_flag() and detach_filter_clears_reattach() cover the
> ways to attach a queue without a filter.
> 
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>

Reviewed-by: Willem de Bruijn <willemb@google.com>
