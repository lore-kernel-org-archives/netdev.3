Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683773;
	b=2QhSNhKvAt5jRgfFIGZc4z3R4Au/3MFz5UfSRpSheX4AxYI/Qlul3jQRMve1PR7T9vTS
	 ksPRT43CB7tt9IPp4/1NFxZNVFqr9ntL1gD2jR+7WWsROV+voq7hl2LTyrnV2g9BnzlSr
	 iWmyJ02eIvdGAAVjvaDu1ij7zSDqAyN1VJF9HHCZf7cldicPhdPl3/+50ZLTSO15CqkND
	 TJ1V7sCYkDgQocn3vkVMI0sRbUObUudXiTR5WMUeGzunHbFjL+5NnnwFxgCC8X10AxFsl
	 rKEGyKD3pxWAUr/h+jv+zLmpN/tMAd+pimuUQspQJtgpawXR8FABr9FtL4l8RJtrDnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ke9vhkENAXPfCm1yxHfr+SbOqiszin1sS4qIXy02ijk=;
	b=zAAH+G4LrxCHlTuxgyn7ErH+KnB/HmrPpHosjacG6eS1hrXYrvU4ytVynKY61NB7MWHR
	 LZ76QrGVbtVZonN5lN+S+fXnDl3HxL1++XuYYga4LrRafgyRpjod1iC8QDyLVaMJdyJKD
	 +dv4FwuPZ+RJSz/OqBQQCvOTQAgO/N4w2lG1ku4/AL1V8HWMWeSWbzSONlIm0fa+APHt6
	 SPGSSAHtHkW9rn4LH8rrc3fdGlAjpe20Gcw/etcK9c41o3eWA6/Jlwbv2JoUDbOQ+SnC6
	 ukF+nCS2LiOrwYHzvZjKsGqmQF+k15PD4svTIHhONKz7zmDem9B9NHnQrQtVaxUGNNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UmzAFCtx;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F19606A338
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 05:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81F19606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UmzAFCtx
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eb362d1f5eso39796635ad.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 21:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793683773; x=1794288573; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ke9vhkENAXPfCm1yxHfr+SbOqiszin1sS4qIXy02ijk=;
        b=UmzAFCtxp1ZYyFABxl1CisByc7Hr2e969siZsRVUO5jvr9m5lyMi3dsG2NZaa6DbkS
         Q8filMC2M4hVX6GaGHy3WskJo5Ss81YXxBmHv8Gi3cYWgKeSPF/RHDi5+dirS5fixcse
         lmlGFAnXepRzUL004qTIZUB77qN5VCnadqWy0pYWfUhEFZZs52UGP/bbyIqea7T6Z9vn
         DhELoXdUTRArq8p4XtGXSWvwgHHdcbHZOXSSL+egm063O5C4EG5katn0QWTJQvViSFD3
         fikNYAgztw0YQOL9Nb7azqmVcP8aky6HDdQz0uv/e0/YqjmnYm/mNXTh+9aJgyQVZzM1
         YQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793683773; x=1794288573;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ke9vhkENAXPfCm1yxHfr+SbOqiszin1sS4qIXy02ijk=;
        b=ON9Ius9fXE5Z2wY3EUXOma81Vs19/O4rpz2W/ivcWP9fFlWv0sHnBs33tjtjXgUZit
         fIxzoy/v1CWRpnAx+pavYHps67kDgWiHoyB5t0+skxHUiwO2BQTj8GhWTV+BnJg9jpFh
         HrU8yYFzTWoC6VONC7MBhlzXpLIr8uQp68+uf4hnWvS3wXiUZ2qe1y6eGBmbeu6mZyPb
         hsQXOv7mHvfkhojGz3mKCZSsPMEcMNbJ7ELOn/bccOtAgbVMcL8yLkAT9LCGPFq9qSRn
         etWJF7bwtVY60pBJkyQVnfSYJnqu06awkMg6H0OJg4zggBo52kp0S1BfRTYOVQosNwQB
         95Qw==
X-Gm-Message-State: APuU4Z8tX1pJE5RbfG2IH4Uj1jpPnbiBotB9uWRFSUEiJmd9XyUtq8jL
	RkwvuuF4usSBQkWLovkjbf0ZtLvs2Qa8J38/7/Tmt5GlcYo4nsZlde/Sj0vUTa91a67FGJkCQRi
	F6tmNXA==
X-Received: from plbbb6.prod.google.com ([2002:a17:902:bc86:b0:2e8:18c6:a093])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f712:b0:2e9:5829:9b40
 with SMTP id d9443c01a7336-2eb3649be7emr111118405ad.9.1793683772335; Mon, 02
 Nov 2026 21:29:32 -0800 (PST)
Date: Tue, 3 Nov 2026 05:29:31 +0000
In-Reply-To: <20261101061331.286404-5-jiayuan.chen@linux.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261101061331.286404-1-jiayuan.chen@linux.dev> <20261101061331.286404-5-jiayuan.chen@linux.dev>
Message-ID: <aulxMqNrVTWFRuv3@google.com>
Subject: Re: [PATCH net v3 4/5] ipv4: restrict igmp_qrv to 255
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Fernando Fernandez Mancera <fmancera@suse.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Joel Granados <joel.granados@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Maoyi Xie <maoyi.xie@ntu.edu.sg>, 
	Jiri Wiesner <jwiesner@suse.de>, Oleg Nesterov <oleg@redhat.com>, Gerd Rausch <gerd.rausch@oracle.com>, 
	Neal Cardwell <ncardwell@google.com>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	Yung Chih Su <yuuchihsu@gmail.com>, Wyatt Feng <bronzed_45_vested@icloud.com>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, Flavio Leitner <fbl@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, 01 Nov 2026 14:12:02 +0800, Jiayuan Chen wrote:
> net.ipv4.igmp_qrv only has a lower bound, but ip_mc_reset() stores it
> into the u8 in_device::mr_qrv, and the IGMPv3 retransmit counters filled
> from it (crcount, sf_crcount) are u8 as well. Anything above 255
> silently wraps. With 256, mr_qrv becomes 0, every
> "in_dev->mr_qrv ?: sysctl_igmp_qrv" falls back to 256, which truncates
> to 0 again in crcount, and igmpv3_send_cr() never puts the state change
> records for the group into a report. The older version querier present
> timeout (mr_qrv * mr_qi + mr_qri) also collapses to just mr_qri.
> 
> Make the sysctl a u8 like mr_qrv and switch to proc_dou8vec_minmax(),
> which rejects anything above 255, and document it.
> 
> Fixes: a9fe8e29945d ("ipv4: implement igmp_qrv sysctl to tune igmp robustness variable")
> Cc: stable@vger.kernel.org
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
