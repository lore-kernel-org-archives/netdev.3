Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511252;
	b=ugbXXFczJ3VEBRdiXE54m30opITAWXzLnNyshhWCPJmrNicrc4uC/KCTUzq35Iynmdu+
	 k+mhe1wOllgrsAhQKTRe3qgQtfg1g+huSlEktzxDFNEW0X6Rub4eLmo4mRD9sOK/3B7JO
	 rM7ydQF9EsHYzA994PCZlHSiIgPbGth8u+96i6jyLCoXG1zqS86P5r5W61dAYiE85QWMF
	 sSzBEWezOf+jGB755HvqlElkZzKClFLv4HiIKVoxCCmtmPo6r6oLiouoBbR5KlUWTMak2
	 rzh/I+WkciI3yF+SULgxc+1Vuy2Ddnnr/ndZf7ag7NlEar5at+/5h5TRQFR3hLof/Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=bfQ4W09NB0+NwKg8cP0sb9j3FSEtD3mmTAXdVQHhhdA=;
	b=mG09ALVE4kX24Y2Kt0j3O57alqFurpan0gttn2eH4bc6+8KNyTu7XezPayhR63nD4yma
	 diZHdA2YzL8CWnuI27o55lCxfiudXwwyYGs9GX+xbU6/+qQpAVnLJrlaC6Z//CSHfgv+i
	 YrOcT3mWdbZ94huzYcoWV6XUU9Hv7Lle8yvvVnV3gMDOYvLkbT+6nyz2bNwdZ6QLFhOu6
	 dHbYV8Ju1FZ8Jv0IooMJXOTT/F3JXRx5RAtIK8RryOTiuQgq3NvObf6vDx1zU3Xcmn3KM
	 4dNMZ9lQS2KK4CxUGl3z+8BRv8hSZs/UGwJah158AruVWYa8irHr2onIVY2PuPu7Kig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hfBOJrwa;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD86606A32A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BD86606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hfBOJrwa
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1e34ecb02so18078125e9.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792511250; x=1793116050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bfQ4W09NB0+NwKg8cP0sb9j3FSEtD3mmTAXdVQHhhdA=;
        b=hfBOJrwamHlvg3Tc7VBjHnCBeFmhcVdrrZwddWmLyBbU//Ycen7YKqT6MJclhXBwbp
         teO+5PFMbBswBUsYgNNLTG1aU/cXEvx/cCYs/8CkrBrQbmhJYVcZMtpBmdvLA3Vd/myf
         rkLHRDl/FBW3w9Busut3qzOdqIBbf6NAE5W0rVgF/kNdjTpqYqG7vIfh303iNj2qHKok
         8J1ZeTAxnbaBjX8XsgP2/YIFCNNYDRdsxtNnvyFj2MbMuXLM24lLtJ0QV6pEzl8TEMVD
         adr0Lm709tS9Bt0Sdur8AzapRYy0Y2qdv/JiFUPSMQOrV2iDwLFf6gHvqKiRL1r8q6TT
         mQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511250; x=1793116050;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfQ4W09NB0+NwKg8cP0sb9j3FSEtD3mmTAXdVQHhhdA=;
        b=c8l95fLKhQN9qQ/ImVzWMVRl3Y6jpun00h5KvNJk13cLLrDZKBGdDaPVI4Iw44Ghmm
         9aa+cUP4eezI18LPwSjdpgzm71gB1WLI1SVf/69butCHfXI7ar6B4+8S+u9LjLOuZ2cr
         WJTCgkiZiaL4iE1riXCO5Uy1YfKZTuJY11pIfw5n3N7VvLfOldL4GHhqMd3hxknLeMBt
         7++lPWwDmyJMY5tkhD7v6hDJwHlLPKu9Ga95oga9tarRtsjypp24ERxiYaMekfq2oWYH
         /GA9CqHNOqJyMn17f+t9OAB7GTGe4Ekcr5QSu0Bv1rVqB8PLtzeEEU4oa0j3Xbzumt0A
         0egg==
X-Forwarded-Encrypted: i=1; AKwUvBzOK2IGK9BiSc5DO3zxPCxctDFxkiWprtW6+uSe5oQhT15weamFNd5LJBZith4GVB5NPquH7QE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOfQS513D+Sg1gMRzboENBC8mP4P8GfvoR5SDPt8MZOJQ9yoJK
	hoFcNe+sj4rYBIo8KlrAdtsuwBxcnOzAcZX/4vw/7w42/lZ+1orasmLa
X-Gm-Gg: AYBFou0+iz7J0qrRkD1cim8bpZBm999ac7944y+XkNJbvIqoHoF2KADk0jdpMGKotDC
	kKGLLmHiFs0UpU+FU4ziE6x9rYytueeOjLtuhN6tTZ5XsmfGQ7Zx30I2GJZMHIkIh0YAle7syWo
	H/P6jCWZ8x5kJpp0W6pHU0rJIAOKqiXAhunfg7rvjmfvdO8YVGDdyrJyuLkf9qHt45X53Ud1DSR
	UI+5u3THTMiZ33fkhLjqCKHmlRSTYToK/faaawQO8Q+5k2LZc2Z6qFactHeuGQIPjM8UzodEXHl
	lWBPTXz1PAt40wpozgo9iusAPAMQRKuTc+VJ/RdHPEr1plKbAyDuCdrolqeqnDxMBWFpr+H3mzL
	At7zcjWSlbd5nVTVhZMh7lZWypuM6dh6iMVNc8xwj3+UXmvrTFdXO24KsoxRF0UiYi6DewfS7DQ
	/sWB2+QUrdqRbGtk9mp9IVdES7MNNGw3u9XbmTqh3ZN9FJ+kkDK7iy/v3WEx+1RYy1ybNiqOGdh
	JhLvUM4AY13Va8M5cMDhd43nS3ams+v1plr
X-Received: by 2002:a05:600c:3b91:b0:4a1:e0b7:ff09 with SMTP id 5b1f17b1804b1-4a1e0b80060mr221153195e9.33.1792511250372;
        Tue, 20 Oct 2026 08:47:30 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d57ef7sm100402205e9.11.2026.10.20.08.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:47:29 -0700 (PDT)
Date: Tue, 20 Oct 2026 17:47:28 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, willemb@google.com, eddyz87@gmail.com,
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org,
	horms@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, yonghong.song@linux.dev, jolsa@kernel.org,
	kuniyu@google.com, memxor@gmail.com, emil@etsalapatis.com,
	almagui@kernel.org
Subject: Re: [PATCH bpf-next 0/8] bpf: Expand ksock send-path support
Message-ID: <ateNEHabOb81MRLU@gmail.com>
References: <20261020102512.518479-1-mahe.tardy@gmail.com>
 <DM9RCU3BDWEG.1C32ZIVU95S76@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM9RCU3BDWEG.1C32ZIVU95S76@gmail.com>

On Tue, Oct 20, 2026 at 03:07:31PM +0000, Alexei Starovoitov wrote:
> On Tue, Oct 20, 2026 at 03:25 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> > * allow bpf_ksock_connect() to be called in the send path
> > * add bpf_ksock_sendto() kfunc to complement to bpf_ksock_send()
> >
> > This is useful when using ksock to reply to differents peers while
> > reusing the same UDP socket and generally works toward the goal of ksock
> > to support the basic socket operations.
> 
> can we drop connect from LSM progs and patches 1-5 altogether ?
> bpf_ksock_sendto() alone replies to different peers on one socket.
> 
> connect + send from LSM progs can't do that reliably. The socket is
> shared through the kptr and sleepable progs run concurrently. Between
> bpf_ksock_connect(A) and bpf_ksock_send() on one CPU, another CPU does
> bpf_ksock_connect(B) and the datagram for A goes to B.
> 
> Without connect there, acquire/release in socket_sendmsg has no user:
> nothing can be done with that reference. bpf_ksock_sendto() is in
> ksock_kfunc_btf_ids, so the current filter rejects it in socket_sendmsg
> already. Then no need for bpf_ksock_send_id, bpf_ksock_sendto_id,
> bpf_ksock_connect_id, bpf_lsm_socket_connect_id and the cycle comment.
> 
> Selftests are left out below. Patch 8 stays as is, patch 7 stays
> without the socket_connect hunk.
> 

Okay, agree it's simpler! Let me send this as v2.

[...]

> 
> pw-bot: cr
