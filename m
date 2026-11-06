Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957224;
	b=eEk13QObtQfeQjaIx4d0Ma9dLzfz9Y1TxE5n2bJWHts4CaOmpfzhHV2Ey0SAxnYJDEci
	 NrtMLUi26ywMEVhbbXiqZBeqoOZR59AGVUbfOeN7REx5EcbqXqJ9mlf2NuhTv7G80L1x5
	 aDSIFceFlQn05AE+FnIRJfCqBzhn88UD31KKye2q/Vr2/26Bten7NHS1SZuUQMGr6YXJD
	 aYWcocLRasB1O0LNxwFPqmCgOnLoAFO36rujg4vdpqS6cFn91poxQp9MKap32H30H7qH/
	 JwFqbnYtT3CunmnzTCf0NW5O7BbV5u3eqMdCcKR9prisdNHRxzGhqPiAwy9Pbhnzg3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hLqKl4DHf1/3oE13SQ+fGSWLoGkn3xwzGKOEnxMd+2c=;
	b=ppKOs3WgQahecWm6OG+DGOYicCYiMowNB/5jYr3XSTTWZrZn+yYAfh9pIg5qQ7CxQw56
	 62MKPel+TOpQSFixsRwcVAv/eNgVqgYeTxtRExyY9PF+Ehvx4unEd2sUmCorxZ6bepDUk
	 0p4kyus60oFZBP6kGkjlAaoltEBp+QHgcQgP2kxlrw4CQEnpyLs/sQ1n7CwDR8hTK7k7k
	 qbFIGrcnvGw49nRgYgINEKnmvz20JECGWxeWb5TtO45dCkDHYINdQoBilFgKA38/yFcbC
	 wBkH8MrOGR/EOvQZVYsWInweNjsQvbG7+vHB/fspUdYz2xa4nH6CiNJ5PHLq3Mf/7ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ad79GImo;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D5606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 09:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 009D5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ad79GImo
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d30639709so49373466b.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 01:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793957222; x=1794562022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hLqKl4DHf1/3oE13SQ+fGSWLoGkn3xwzGKOEnxMd+2c=;
        b=Ad79GImoOiVoZjaMQhhocTzrz3/FK8bJxCcn/v6yEBOAfDlg5eeothyGeiGbK0RQOs
         kIXMPY2MQ/JXoCvzh4Boo5g1DDKrDB7zNergHITfGMukmna63nZPldAvZ5WoSs8R0HsP
         VZXJXIu7HL6XPE97I1HveEi0H+le2OO1ohEtu1pqkonUxXK19BPbkafySl2ot+I71AQs
         RJIEU6UGwcdmOKQXqm+q68V2jWVBFQ2CWUa5CFpaAK6aTXOISBWgELV4KCAFgEqWuulQ
         Rsq3bqA4Yk/7+NeYS+L7r2kfypv/8kLtuP4Sv5o1qEck0Ej622yXP8414KIsut28ARp2
         W39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793957222; x=1794562022;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hLqKl4DHf1/3oE13SQ+fGSWLoGkn3xwzGKOEnxMd+2c=;
        b=vJw0AlUHfq4+uOw76TDpHSVcTKYcDB7rytHaKl0fc0eo4HEvF1ZlTqF6Kg0X1zUW2x
         F4IVwyLfYjh7zssWCrDvUuzHOrmkA0dUmAr8Ub/JsrAEN9XLAXg3C3kfPR5CLGjaZlYf
         XjNuDsON0ndeipBFM2vKSUe1D7zygLnHF1NeJ/lWybSc1dMrIKTau+31qB+CpsAiFA5y
         oAsyW1YPKr3lRL69Pr2zVTmUBOZ/iUEdkahQXIBs8Go9ZlBPRuonzEwFwl9pV/dS622I
         V+rEDI5NdzgeWFCITatKxAbMr66hgY1OwRFMNL7RG0OJU9NaOuqWtgumCMog9tPfrWLl
         MGWQ==
X-Gm-Message-State: APuU4Z/7WR95+ldmUkpr2RmxOdy3UW9C3J2tm7OpYhx49wmKyuQ/FIUo
	i9gumF06SEZde8MYY3+BbceNM7J5da2yOK1ZrJhNf9bf1E7SAJEIEA2e+iWzmhVLcxzh9e8zB4l
	VCXrNces=
X-Gm-Gg: AYBFou1iGsqs93t5mGeYU5OTIXWVJtJkCEY01BTN8g4lGn52sMJonsVqtNkCR36oa7C
	5hpvaKf7Fyzff6otPYV3eUeNG7lE3q4qjNm9mkaTMieU02k5RmPk3mfQk5wbvx4jU0QWmnVFdbl
	VRvfuZTaajg8Ey7kYzRXaSqb0G2nW1tJOUvILMp3yfq3mLOy9keR+9K5E4RKmzh6RYWjUyeQV6i
	ds2n1LWzc34vLqyS3ofWbZ8g1e65gotwY/kxCPqTuGuouW0cHoxZ9LJEGR9VmO10B99kgweWIko
	Bg0onf4IRnDv81q4n2soOpSUXulOwMSdiTXNSL1TGkr3AlsxpwQhyfBjEYfcZCRxZv2uVl7jovi
	xvtunG5hIv2/mWrXHOsyNPAdB9WURjMYvpOjQsT88SBLdvJjgBFstHk2r8q1HKGYMRjsTTM3HBG
	Ce8jIT7avwkUBzmvCc7DeUcUD4v6cmNgot2g5N3u7EO+n69YvVy6PgzzeCNBQ4a1ODAs/OZXNAQ
	z87xycsBES9fbcR0hAHC/lBQFWaptNF30HkJeqQefhZVQqRvIq0MowOJG4Owmmm0Wz+w6ovlh0I
	2lSewX0VN/VqcXs9+H1lAv1tk/Zbo+e3/ZCxTm8ORwbzyR/IxYO25ncgXU96YwjwiSj+AXsIuZ8
	MkRiamaYQEu2Pg4vwyOHaRBZHCVK+vT60Ytpc
X-Received: by 2002:a17:906:7316:b0:c4d:a05:a2e4 with SMTP id a640c23a62f3a-c4d34b9e16dmr162861466b.20.1793957221759;
        Fri, 06 Nov 2026 01:27:01 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be. [194.78.224.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356c1ee1sm63006166b.64.2026.11.06.01.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:27:01 -0800 (PST)
Date: Fri, 6 Nov 2026 10:26:59 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Stefano
 Garzarella <sgarzare@redhat.com>, <virtualization@lists.linux.dev>, Bobby
 Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH RFC iproute2-next 2/2] ip: add "ip vsock" to move the
 guest vsock device to a netns
Message-ID: <20261106102659.77f8ba56@stephen-xps.local>
In-Reply-To: <20261105-vsock-guest-ns-v1-2-b1c11b3b69c7@meta.com>
References: <20261105-vsock-guest-ns-v1-0-b1c11b3b69c7@meta.com>
	<20261105-vsock-guest-ns-v1-2-b1c11b3b69c7@meta.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Nov 2026 11:30:36 -0800
Bobby Eshleman <bobbyeshleman@meta.com> wrote:

> + * The guest's vsock device is not a netdev, so rtnetlink cannot move it.
> + * The "vsock" generic netlink family moves it with VSOCK_CMD_DEV_NETNS_SET
> + * and reports where it is with VSOCK_CMD_DEV_NETNS_GET. There is nothing to
> + * name in a request: the kernel serves it in the namespace of the socket it
> + * arrived on, so the destination is chosen by sending it from there, and the
> + * reported namespace is an nsid relative to the sender.
> + */

Please be more concise in comments, AI seems to think it gets paid by word.
