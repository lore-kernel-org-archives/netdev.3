Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792772300;
	b=RKD9SgrLyfKU3utT8MLmpsfdh0MLNgqBrqO0dYcvymAFWzvq4HlXSnlhtM3eW/9Pa1G3
	 2l2SXb4xyXdpcZGBnE9tgj5m4hCORX2mg6/w6baDNqwgToKV0agr7M/JY2pKMG8SKqxsM
	 1kRsdwAOQEuPUaf1ec4orXrBlMUCoJEoUD9WSK/+iZArOlI1mGsFRLSJCDSb14YiOClWm
	 /zmWs5Inc2eY5ipSZHEZZceVWifyS2GGmSRduzpRLbMaK06w5xEw6cpnPoDBGA+EK1VRp
	 ZlrZHiGWmrYMzBpI6vv7IIPoWdx6vsksw0MNeAJTYVrXFxDmHmlS5SJ6JAfGt3y6wcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=YsxMGUxqL8pZTvfr06ae0Ub6YjRoY4ulbyov/TUYsGo=;
	b=RiUx7dYOP93eHgSxOc8pUivwtmtYxS2m4wyNuSs0U42EAOH5oDMfNwYK66EOWK2ncc0T
	 fx8iYgeo2bFJ0jTYvYn3jSdKt3RoOTudXck0hzK+U5qm2KqVDPC3TT2yovP7IaZ51xqLz
	 hB6bcJF+De824tT6XRxTGSvbVKWwT+w9JS+UzB5QHLUgk/bsTP+04nTZ1nolesdvAszCE
	 adOIuVW7uzVkZ8xILmPEdG3OuM48V1GjPmrmanOSatvbz+SOY5W26Euxv5K1KH3sclHxv
	 eRwxDU8A3Hoihwcl1tKYcAmczzD9jxn+c5GYUlHmJ+O1toNIpzn8+1YYA+MnNMvn/aA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="R80oWK9/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F69606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 16:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7F69606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=R80oWK9/
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso10799a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:18:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792772298; cv=none;
        d=google.com; s=arc-20260327;
        b=PnxdDycNSXbrw3paB98DRsWkpcrZdUuCUipdI8emXE0h72ztJ14eez6wH0y0FzxYQj
         4nQiqlGV7r8lIKMUhgLozSYS7rRkhnrpRdmDalxC5zsN6Zd0zlSbXaITuBBAHQNTT1pa
         zyfDjuSaPYhMViQomnVtrM5G7qutiZ0CrnXuP4t5tZoYRWQfBuldNKNoR5QdhHm/epI8
         I0bqjuFx8LOWjZ8pDY/r2MdexAu8jxI28jGZJUcek2iMbcFLrYjBHxYL4qwMCDTCozc5
         zt3HPdNXTh5yZlbphg8lqiek2MJGTBC9eD+cgnAbDQCtWZDG8vWSA6KDKn6EL4+M0tZa
         4Y4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YsxMGUxqL8pZTvfr06ae0Ub6YjRoY4ulbyov/TUYsGo=;
        fh=LhGvTIFrbSIdJW6wBkJjhS+o/EvjOZHfIleN4QNYaRU=;
        b=MNCG+YQ/+uXpfcCqkzwXqd5UZ1jpBB7ZuMayqffw2Lzki6PGDSTz40ntsluByoUMAb
         8utkiycC6Pf4bBVdSig5Z2JCKPhRkW2YtWdQ64CQSxSULWCXgvF/a0E2Hyer1nVgX3oa
         lUuZWvEowICWh2JdR73h4Fl7jnRgG39dNBGNSgagMKpZmq9HOPVyWnITbiRoTe6sNaPQ
         iYoU1hOgTEsbcRtKSDR32jdXhEXnd16awQNDCCtQn+CvW3u198YTGuWjesy7pUQ/RIR0
         BkqQS+hweVlDHGywtnFvnuthrty33QlTWpnOtjzOP+YbhlsAqfTRO3B87Qp8PSCaqjSQ
         ChAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792772298; x=1793377098; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YsxMGUxqL8pZTvfr06ae0Ub6YjRoY4ulbyov/TUYsGo=;
        b=R80oWK9/eVyaoMMzgzaEiojHRsad9aC1oAXpwRjRvsHmDoftDFClClYyuDY/dxrUVU
         19w2sb3dqxu8r0hUWVObbqE14biLOQwAWjartSNT2/5xeJQNHJV7oWICCur0aHUdr9SN
         00mGDLw7BYJu3zDOUQ8pk4tK9B2H/g5tnpKgb5aAhPCtFEr6/OTRwQoAo72Wd/gzOyWY
         2QRsQZzYNKeBz/56kiwUgMfrcml6EMjYJU+NnZqQXhQugCiZQxFcZ7GPW92P4Qy4Mxfi
         VvfQrOVWO62FtUOkBxhimrh6ccSy3ii5b2jtf9UvXdcacv7ToIK3yDZLdfjIjhkMlviZ
         w84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792772298; x=1793377098;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YsxMGUxqL8pZTvfr06ae0Ub6YjRoY4ulbyov/TUYsGo=;
        b=YTCF4Ekz5HeC3i2183ejpRU1X5LW3ZGYEfFlqAyDFLH5YsE9a9YP8/JmprQ6JFfFlD
         Fg1zfsnjGB/vZPUeCAhirVtNut3NNj9PuBxKMkljJZswOuYnOntG5cQ7WDhJyJoY3gGQ
         7QVvRxF0bbuPWAxEq5M7xcgJurhPXxI4YvsfY5Qoa+0jUHmSMDgP+3wf9lOUkEuoroLa
         XlXBOLkZz0tOZbpWr0gzMJHr3Cl+d9Wi7sTAS5tY3Bg/MgrCTd0S9AY6EpGCBcwrLiJ2
         ANl1JYWCSVCfNknAhLjLaCjlVmxeZO6cDX9UxYeYDDsrXaCRABVw1CJlU1OEZMrSspOg
         Ja2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwLfHgq60DR+aRmunzyaK53nQBpf9t2A8bo4gduLUpzCjy02IYdhwpcW8hwjFexS5YoN6bChaE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJA6uAMlSYOfWxKxT3W3nGZAqs0feZO6YUX1hI/4AwpfkNyf10k
	b0PfaQ0uRycNcuQ3okKzS5vKWju78iWm0zww1Ck0dpSY0GtcXKnvedIeh8DsN+3tfzmBw4c02Uf
	MG4znLUk6ixYX31Puueb8iI6F/1SKu1TTGYwpis5l
X-Gm-Gg: AYBFou2TTQYaAoVxiIW+06oYYAZQl0lyz7ZGhja5AlKXJ8RfkS/W9j2SG3cHlbk2O/k
	dvFynoRpctvXzv4sk1B8zhA19VqrSW+UsHP1cFpKsnOBl/HXzb+3TGiaRRkX4Qgd+ETqSpkOkYZ
	RB35hBgBrHGVU51CjDBNxRygiCXRHVi/GhDRx9hJQUMBzuVUCTmOPExA3fchL6bcamQ+HsDWuWf
	8M4X7Kz+sx/qYfnjWdhPSEoLQ7PNq9vTeLsBJ1kXxI24l3Di5pWZAv7SD6QpGl72Q10lTpl3E/b
	3UJb+uKoGc+DrGc+9X/5g2GwO069vZnX7LhAXVgY3HyV7RetwSWdDPWtqLCNFJ4mPq01kx000Y7
	xdPUZ+oGQMwwPJLIn7DKKZwETyBeGPDIH5uywIqsmRECiqnRAuOVAudWKJrOk7VhddzyFIZjD6F
	MJixA8QliwGWqlS2T7s6XKoXl5bA+EP+HAXmMjVsGyS3Ce
X-Received: by 2002:aa7:d347:0:b0:6af:afce:184f with SMTP id
 4fb4d7f45d1cf-6b432d1bc15mr62920a12.3.1792772297426; Fri, 23 Oct 2026
 09:18:17 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2ab9dc5f5b5e9f50d7a4aa02a6b6759fc86314c7.1792658454.git.gnault@redhat.com>
 <CAL4WiirZKwGSP6w5vtbEQ-KXY3qR_ie3HuyRuF_JVEoC3PiO4A@mail.gmail.com>
In-Reply-To: <CAL4WiirZKwGSP6w5vtbEQ-KXY3qR_ie3HuyRuF_JVEoC3PiO4A@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 23 Oct 2026 12:17:53 -0400
X-Gm-Features: AclHuK8nJ9K-kZi0mExZJi5ykyYY3MxCz0X230E5w46xqF773ump7jnn6B67GGE
Message-ID: <CADVnQy=KOBo2bvWrT78AGfkJ7BUjM9uGFAwJ8e9EQR+k1FTS4A@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix dup-ack detection on non-SACK bidirectional
 data transfer.
To: Eric Dumazet <edumazet@kernel.org>
Cc: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Tom Williams <Tom.D.Williams@morganstanley.com>
Content-Type: multipart/mixed; boundary="000000000000f568eb065e845381"

--000000000000f568eb065e845381
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 5:47=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
> One behavior change to keep in mind: because of the "|| !nwin" clause
> in tcp_may_update_window(), every zero-window ACK used to carry
> FLAG_WIN_UPDATE and was never considered as a dupack.
> After this patch, repeated "win 0" ACKs at snd_una with outstanding
> data (receiver dropping in-flight packets because its queue is full)
> will be counted as dupacks and can trigger fast retransmit + cwnd
> reduction while the peer is simply stalled.
> This is RFC compliant, I think this is fine, but a packetdrill test
> covering this case would be nice.

I agree with Eric's point, and agree it should be acceptable.

I asked an LLM to cook a packetdrill test based on Eric's suggestion,
and it LGTM. I've attached it. I can post it officially if folks agree
it's useful.

thanks,
neal

--000000000000f568eb065e845381
Content-Type: application/octet-stream; 
	name="tcp_zero_wnd_dupack_nosack.pkt"
Content-Disposition: attachment; filename="tcp_zero_wnd_dupack_nosack.pkt"
Content-Transfer-Encoding: base64
Content-ID: <f_mvl69i5u0>
X-Attachment-Id: f_mvl69i5u0

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKLy8KLy8gVGVzdCBhIG5vbi1TQUNL
IHNlbmRlciB0aGF0IHJlY2VpdmVzIHJlcGVhdGVkIHplcm8td2luZG93IEFDS3MgYXQgU05ELlVO
QQovLyB3aGlsZSBkYXRhIGlzIG91dHN0YW5kaW5nOiB0aGUgcmVjZWl2ZXIncyBxdWV1ZSBpcyBm
dWxsLCBzbyBpdCBkcm9wcyB0aGUKLy8gaW4tZmxpZ2h0IGRhdGEgYW5kIHNlbmRzIGEgemVyby13
aW5kb3cgQUNLIGZvciBlYWNoIGRyb3BwZWQgc2VnbWVudC4KLy8KLy8gT25seSB0aGUgZmlyc3Qg
emVyby13aW5kb3cgQUNLIGNoYW5nZXMgdGhlIHdpbmRvdyAoc25kX3duZCBnb2VzIHRvIDApLgov
LyBUaGUgZm9sbG93aW5nIGlkZW50aWNhbCBBQ0tzIG1lZXQgZXZlcnkgY29uZGl0aW9uIGluIHRo
ZSBSRkMgNTY4MQovLyBkZWZpbml0aW9uIG9mIGEgZHVwbGljYXRlIEFDSywgc28gdGhlIHRoaXJk
IG9uZSB0cmlnZ2VycyBhIE5ld1Jlbm8gZmFzdAovLyByZXRyYW5zbWl0IGFuZCBhIGN3bmQgcmVk
dWN0aW9uLiBXaXRoIHNuZF93bmQgPT0gMCwgdGhhdCByZXRyYW5zbWl0IGFsc28KLy8gYWN0cyBh
cyBhIHplcm8gd2luZG93IHByb2JlIChzZWUgX190Y3BfcmV0cmFuc21pdF9za2IoKSkuCi8vCi8v
IEJlZm9yZSAidGNwOiBGaXggZHVwLWFjayBkZXRlY3Rpb24gb24gbm9uLVNBQ0sgYmlkaXJlY3Rp
b25hbCBkYXRhCi8vIHRyYW5zZmVyLiIsIGFsbCB6ZXJvLXdpbmRvdyBBQ0tzIGdvdCBGTEFHX1dJ
Tl9VUERBVEUgKGJlY2F1c2Ugb2YgdGhlCi8vICJ8fCAhbndpbiIgY2xhdXNlIGluIHRjcF9tYXlf
dXBkYXRlX3dpbmRvdygpKSwgc28gbm9uZSB3YXMgY291bnRlZCBhcyBhCi8vIGR1cGFjay4gSW5z
dGVhZCwgdGhlIGZpcnN0IHJldHJhbnNtaXQgd2FzIHRoZSB6ZXJvIHdpbmRvdyBwcm9iZSBzZW50
IGJ5Ci8vIHRoZSBSVE8gdGltZXIsIGF0IHRoZSBzYW1lIHRpbWUgYXMgdGhlIHNlY29uZCByZXRy
YW5zbWl0IGJlbG93LCB3aXRoIHRoZQovLyBzYW1lIGN3bmQgYW5kIHNzdGhyZXNoLgoKYC4vZGVm
YXVsdHMuc2hgCgovLyBFc3RhYmxpc2ggYSBjb25uZWN0aW9uLiBUaGUgcGVlciBzdXBwb3J0cyBu
ZWl0aGVyIFNBQ0sgbm9yIHRpbWVzdGFtcHMuCiAgICAwIHNvY2tldCguLi4sIFNPQ0tfU1RSRUFN
LCBJUFBST1RPX1RDUCkgPSAzCiAgICswIHNldHNvY2tvcHQoMywgU09MX1NPQ0tFVCwgU09fUkVV
U0VBRERSLCBbMV0sIDQpID0gMAogICArMCBiaW5kKDMsIC4uLiwgLi4uKSA9IDAKICAgKzAgbGlz
dGVuKDMsIDEpID0gMAoKICAgKzAgPCBTIDA6MCgwKSB3aW4gMzI3OTIgPG1zcyAxMDAwLG5vcCx3
c2NhbGUgNz4KICAgKzAgPiBTLiAwOjAoMCkgYWNrIDEgPG1zcyAxNDYwLG5vcCx3c2NhbGUgOD4K
ICArLjEgPCAuIDE6MSgwKSBhY2sgMSB3aW4gMzIwCiAgICswIGFjY2VwdCgzLCAuLi4sIC4uLikg
PSA0CgovLyBTZW5kIDEwIE1TUy4KICAgKzAgd3JpdGUoNCwgLi4uLCAxMDAwMCkgPSAxMDAwMAog
ICArMCA+IFAuIDE6MTAwMDEoMTAwMDApIGFjayAxCgovLyBUaGUgcGVlciBhY2tzIDE6MjAwMSwg
c28gY3duZCBncm93cyB0byAxMi4gVGhlbiB0aGUgcGVlcidzIHJlY2VpdmUgcXVldWUgaXMKLy8g
ZnVsbDogaXQgZHJvcHMgMjAwMTozMDAxIGFuZCBhZHZlcnRpc2VzIGEgemVybyB3aW5kb3cuIE5v
dCBhIGR1cGFjaywgYmVjYXVzZQovLyB0aGUgd2luZG93IGNoYW5nZWQuCiAgKy4xIDwgLiAxOjEo
MCkgYWNrIDIwMDEgd2luIDMyMAogICArMCA8IC4gMToxKDApIGFjayAyMDAxIHdpbiAwCiAgICsw
ICV7CmFzc2VydCB0Y3BpX3NuZF93bmQgPT0gMCwgdGNwaV9zbmRfd25kCmFzc2VydCB0Y3BpX2Nh
X3N0YXRlID09IFRDUF9DQV9PcGVuLCB0Y3BpX2NhX3N0YXRlCmFzc2VydCB0Y3BpX3NhY2tlZCA9
PSAwLCB0Y3BpX3NhY2tlZAphc3NlcnQgdGNwaV9zbmRfY3duZCA9PSAxMiwgdGNwaV9zbmRfY3du
ZAp9JQoKLy8gVGhlIHBlZXIgYWxzbyBkcm9wcyAzMDAxOjQwMDEgYW5kIDQwMDE6NTAwMSwgc2Vu
ZGluZyBhbiBpZGVudGljYWwKLy8gemVyby13aW5kb3cgQUNLIGZvciBlYWNoIG9mIHRoZW06IGR1
cGFja3MuCiAgICswIDwgLiAxOjEoMCkgYWNrIDIwMDEgd2luIDAKICAgKzAgPCAuIDE6MSgwKSBh
Y2sgMjAwMSB3aW4gMAogICArMCAlewphc3NlcnQgdGNwaV9jYV9zdGF0ZSA9PSBUQ1BfQ0FfRGlz
b3JkZXIsIHRjcGlfY2Ffc3RhdGUKYXNzZXJ0IHRjcGlfc2Fja2VkID09IDIsIHRjcGlfc2Fja2Vk
Cn0lCgovLyBUaGUgdGhpcmQgZHVwYWNrIChmb3IgNTAwMTo2MDAxKSB0cmlnZ2VycyBhIGZhc3Qg
cmV0cmFuc21pdCBhbmQgYSBjd25kCi8vIHJlZHVjdGlvbiwgYWx0aG91Z2ggc25kX3duZCBpcyAw
LgogICArMCA8IC4gMToxKDApIGFjayAyMDAxIHdpbiAwCiAgICswID4gLiAyMDAxOjMwMDEoMTAw
MCkgYWNrIDEKICAgKzAgJXsKYXNzZXJ0IHRjcGlfY2Ffc3RhdGUgPT0gVENQX0NBX1JlY292ZXJ5
LCB0Y3BpX2NhX3N0YXRlCmFzc2VydCB0Y3BpX3NuZF9zc3RocmVzaCA9PSA4LCB0Y3BpX3NuZF9z
c3RocmVzaAphc3NlcnQgdGNwaV9zbmRfY3duZCA9PSA1LCB0Y3BpX3NuZF9jd25kCmFzc2VydCB0
Y3BpX2xvc3QgPT0gMSwgdGNwaV9sb3N0CmFzc2VydCB0Y3BpX3JldHJhbnMgPT0gMSwgdGNwaV9y
ZXRyYW5zCn0lCgovLyBaZXJvLXdpbmRvdyBBQ0tzIGZvciB0aGUgb3RoZXIgZHJvcHBlZCBzZWdt
ZW50cywgNjAwMToxMDAwMS4KICAgKzAgPCAuIDE6MSgwKSBhY2sgMjAwMSB3aW4gMAogICArMCA8
IC4gMToxKDApIGFjayAyMDAxIHdpbiAwCiAgICswIDwgLiAxOjEoMCkgYWNrIDIwMDEgd2luIDAK
ICAgKzAgPCAuIDE6MSgwKSBhY2sgMjAwMSB3aW4gMAogICArMCAlewphc3NlcnQgdGNwaV9jYV9z
dGF0ZSA9PSBUQ1BfQ0FfUmVjb3ZlcnksIHRjcGlfY2Ffc3RhdGUKYXNzZXJ0IHRjcGlfc2Fja2Vk
ID09IDcsIHRjcGlfc2Fja2VkCmFzc2VydCB0Y3BpX3Jlb3JkZXJpbmcgPT0gMywgdGNwaV9yZW9y
ZGVyaW5nCn0lCgovLyBUaGUgcGVlciBpcyBzdGlsbCBzdGFsbGVkLCBzbyBpdCBkcm9wcyB0aGUg
ZmFzdCByZXRyYW5zbWl0IGFzIHdlbGwuIFRoYXQKLy8gaXMgb25lIGR1cGFjayBtb3JlIHRoYW4g
cGFja2V0c19vdXQgLSAxLCB3aGljaCBOZXdSZW5vIHRha2VzIGFzIGEgc2lnbiBvZgovLyByZW9y
ZGVyaW5nICh0Y3BfY2hlY2tfcmVub19yZW9yZGVyaW5nKCkpLgogKy4wNSA8IC4gMToxKDApIGFj
ayAyMDAxIHdpbiAwCiAgICswICV7CmFzc2VydCB0Y3BpX3NhY2tlZCA9PSA3LCB0Y3BpX3NhY2tl
ZAphc3NlcnQgdGNwaV9yZW9yZGVyaW5nID09IDgsIHRjcGlfcmVvcmRlcmluZwphc3NlcnQgdGNw
aV9yZW9yZF9zZWVuID09IDEsIHRjcGlfcmVvcmRfc2Vlbgp9JQoKLy8gUlRPIGZpcmVzIDMwMG1z
IGFmdGVyIHRoZSBmYXN0IHJldHJhbnNtaXQuIHNuZF93bmQgaXMgc3RpbGwgMCwgc28KLy8gdGNw
X3JldHJhbnNtaXRfdGltZXIoKSByZXRyYW5zbWl0cyB0aGUgaGVhZCBhcyBhIHplcm8gd2luZG93
IHByb2JlLgogKy4yNSA+IC4gMjAwMTozMDAxKDEwMDApIGFjayAxCiAgICswICV7CmFzc2VydCB0
Y3BpX2NhX3N0YXRlID09IFRDUF9DQV9Mb3NzLCB0Y3BpX2NhX3N0YXRlCmFzc2VydCB0Y3BpX3Nu
ZF9jd25kID09IDEsIHRjcGlfc25kX2N3bmQKYXNzZXJ0IHRjcGlfc25kX3NzdGhyZXNoID09IDgs
IHRjcGlfc25kX3NzdGhyZXNoCmFzc2VydCB0Y3BpX2xvc3QgPT0gOCwgdGNwaV9sb3N0CmFzc2Vy
dCB0Y3BpX3RvdGFsX3JldHJhbnMgPT0gMiwgdGNwaV90b3RhbF9yZXRyYW5zCn0lCgovLyBUaGUg
cGVlciBhcHBsaWNhdGlvbiByZWFkczogdGhlIHBlZXIgYWNjZXB0cyB0aGUgcHJvYmUgYW5kIG9w
ZW5zIGl0cwovLyB3aW5kb3cuIFJlcGFpciBjb250aW51ZXMgaW4gc2xvdyBzdGFydC4KICArLjEg
PCAuIDE6MSgwKSBhY2sgMzAwMSB3aW4gMzIwCiAgICswID4gLiAzMDAxOjUwMDEoMjAwMCkgYWNr
IDEK
--000000000000f568eb065e845381--
