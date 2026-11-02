Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793630171;
	b=iQJ1RB35mX3faQLH/l49WR0FAEBFjYp05cfXkxR+0GRR28/4X7l2Jv998/7NJxocpD8E
	 vYf9F7EUkiBrvVDE7XRpktWvJ2HeL6ss/x8YXO4/94Zu4sAQtsGwT+QdKgvw8VzBgA6+t
	 g0YAxhrtGr2zjvwWm9G+HAOGiBVP/7cZHhclKqK30QdyUu0y+/eveEdjwKVW389btxDbB
	 Tk2AGOObZZSgIl+oNZwrwbgeMBJrCSyDIvF+4rxRRHD2EmM2m3yHFeaHYAcwL7bw0eRtz
	 zUHklmvmxTSUZkx1ORqjIewgfqJGQglCp6V0WlQOedR9HTdS/G3KdCSn3UUlkXswR/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=HZghXhMFCJS70WDNqvvmOeWSzO8R24cAAyoTNl/owqg=;
	b=us5dBv28hJlBkC2AQF74wmKm69otWIwBfqOTqkCu6uFXcb+OLRaPmN1azxIg1/Le3p1j
	 t3ADGdKCwVa/CC1Ghhm+HfdPRsXighDoKuBNfswNtOIond3HNsPMqwN9ZVAqbVR55iRep
	 AKIJVSrL7CpeHuQuPhhe6SPVs35ZWR9xMqQJx1vLH6YVWPKtBTHaH7rIKHEUzNX23uns5
	 fvaS6E0nFBEWjxfCKZxyRmWWUzddfXcXpCGiTkUApCSNZa9eQnmb6sDmmIVg+/1GdL4JS
	 EtwNJR1Km8wQ3utakaw39zFkz/6S+aDvg03IcyYhRIXBczA4VNmcNSoRsuGhjyz4hmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZqXqd1lH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D658606D808
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D658606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZqXqd1lH
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bb7c6980f1so2996653e87.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 06:36:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793630169; cv=none;
        d=google.com; s=arc-20260327;
        b=calvmK2FmA6wIDqo0xP6dRVabXoRwGx0ZMQLzKPxWhdeT6RMgX06jB9EHUJazCvZCZ
         PdhuBc4TfUxZd385Dj0L/xLnZz8uOt9Re3jBPC7OoOiX/1X5MH35qllVVvBzLu8/Kzqa
         t4kYXZWeOk4eDKQ4QBb1mWrVjaw8z5/xXnQ+Qfw6INxFfNPet0FiR1en8RGOnTOFtH8n
         4y3h3aLE7Vk3gDRnJ1Z1Oq267RZLDJmU+GsqK+PE3UPxmiqrh0rr8/Vkp6up8+1DXm7n
         /n7RSjfmw/KSfnSzAnsSbHkidfB/xERzErvjlzaLPKu5/vgMlotxjl7cpGIzLLHWpEgL
         8KZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HZghXhMFCJS70WDNqvvmOeWSzO8R24cAAyoTNl/owqg=;
        fh=RHyf8zTVlMVHoArF44O3PTiSWJwSqgT0sszdhWfVXts=;
        b=ifGcCIBVMVUsyiGradHZpaYOkn1a7COujPQ+ELf7om5+uP/W3Q5p18o/ux80k1DkQX
         TeZC+vkRd5wz0tGR19fmEbGJyw1pNE6ekgrZz38jjMZud0mBSDsdRVhpXMstAc7HPYmw
         zdPr2qUCfsXRF7HzhGiY2rnyqFweHykpW6dkANhTRK1Ej9uG216KUVuNJBcwaDCdOCPc
         5AMoxF/O5qek0H8eB9tAjZhrrtuTMODLTtH9BFfTFf7xhF4aTqPAF0PUEGilbdorp5LY
         78uI669imL6RAgcuDUXef7KVW5gg5rA0RftJdXGzTGCIr5RomU7sE6SK1Alvy2nfx8k1
         8xRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630169; x=1794234969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HZghXhMFCJS70WDNqvvmOeWSzO8R24cAAyoTNl/owqg=;
        b=ZqXqd1lHkyXB3w898qH/EyuKRgPF8azcBo3ws910pWQOSRQxpHTevDPReJeLi/FVDf
         x+Q8yuM2jQHToQ8rLjKQ7qWnGjbk/aWwQTSFufi2EGYaswaRVUBtfjcqlzOJ+ZPJ6cF8
         sB7PEmBPBiisNpFZV+GcDAQYzeKCU+e+AEfy+PJkrMcBOWdBzlVWotauC2d9/iFBh/65
         VlxYbzJHoniNss28lOiqSJMQI+QbNptxnZRBD/LSTZIV38lAFfCB+0A3RVfQLNi1NhYO
         FG7LFih+ylIZMFsh2mz6OCmJkS6wGedHMS6ZHIBdGXkYAohAoRcNvzZ7ewHwUwzJqJ5w
         7kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630169; x=1794234969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZghXhMFCJS70WDNqvvmOeWSzO8R24cAAyoTNl/owqg=;
        b=RfCW2MHOcboKGHFX+HywUd3AungfV2MvRi4SYgToDJXBpxEZg43gKD3RVwNLbBa9Sk
         6n9IBVakTXVbXUvdNpWyOZaIxhaMVs3QS0rGoibLUUga9FE/57RJAya0cTLaexAS1ZN+
         WV7mIoMxrEX7zXqdeWhZCZr5urLHZbiHxzXv+upnEIk3kp0gT/yMK0yiAJWVrFOKKAO4
         wFwsXkrJaLo8ItBAYusOfCrD5MShd3mDw9nyBsRJGR17sPORgk/bYIIs4j5HB9Zrc8Cb
         SBcb5Al0pYqQTZdoPqzms54ShJcgDPWw3aszerLGJqy3Aln32i4TTQn6DG5wklpUjmfQ
         CkRw==
X-Gm-Message-State: APuU4Z+k5hqbBchiazNz4J/LarKEYCn1WNk+1QYN3rUvNI2pFXtC3FP8
	tntkcxVhOVAKtnS6tZWg9W4Kdwoqm65eQFuRDGsFga1mFusv3qCUXvBgE2c3CxuGFSQUAfP2Hsf
	V0Vad6E1NjEYOLaPLcm1R8HhDrDQKXYc=
X-Gm-Gg: AYBFou1WfbQX/FkZWNQDu/3hbXEAQU8xqtLqy2x0a3CHZTLGt8yN0MGNWcAfd2iQMb4
	zrsa68wZ324e0ZXFQDi0TJ8wfMUs3gE5Qx0hRqkTEo1taiGof1vbxwhQ5kBf1HdHIW+RLqZytQQ
	Hf4LfKFnDLIj3p1+ZCkAxLhGey5zccyLpEclkDtGrBSsOhTG7SqD9VYyo/Tl+e991Ga+i9HCt38
	cjTwgcqNbIZcFBxF8Hy56yvnS3IVsJuLa5Sp57/J45kkWDUL8fdMlLKA0jOJ6ghp3mhAY9ryLNH
	V+cOSfLMCQBLKrEDEAWhBWDts5+FykpgNyVGpFHqbdq5mG2ezzD9ih989bBnhIBMRY8YK7vEXMC
	YjrzujkBcHxD7+z/qsJkzZrar7yL5ZwCZWeAu
X-Received: by 2002:a05:6512:1111:b0:5be:5209:9f1e with SMTP id
 2adb3069b0e04-5bfd9560832mr3208623e87.19.1793630169203; Mon, 02 Nov 2026
 06:36:09 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102120929.4077030-1-anilkaushikwireless@gmail.com>
 <179362163558.3286.5335895869912806815@kernel.org> <CAG0Mgm9t=ag05xgP8f0++x0sNG6nOt9zDWbtoKLtgnhnpgm3Dw@mail.gmail.com>
In-Reply-To: <CAG0Mgm9t=ag05xgP8f0++x0sNG6nOt9zDWbtoKLtgnhnpgm3Dw@mail.gmail.com>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Mon, 2 Nov 2026 20:05:57 +0530
X-Gm-Features: AclHuK-Whg2x1OFkVQJyY67gQO23WC_731REREy_bPWfAluMe-tC1psOHzJ0jC4
Message-ID: <CAG0Mgm-O57x8VqpivQQYXxNFrCqsXkQFmZph58wmHQKq6E0m=Q@mail.gmail.com>
Subject: Re: [PATCH net] netlink: Do not call the unbind callback with the
 table locked
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	linux-kernel@vger.kernel.org, stanislaw.gruszka@linux.intel.com, 
	Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry , missed adding Stanislaw and Jiri

Anil

On Mon, Nov 2, 2026 at 6:23=E2=80=AFPM Anil Kaushik
<anilkaushikwireless@gmail.com> wrote:
>
> On Mon, Nov 2, 2026 at 5:43=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrot=
e:
> >
> > Hi!
> >
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >
> >  - Whether the issue was actually triggered, or is only theoretical
> >    (e.g. found by code inspection). If it was triggered please include
> >    the symptoms, like the stack trace or error messages.
> >
> > Please do not repost the series just to address the above. Instead,
> > reply to this email with the missing information, so that reviewers
> > can take it into account. If the series needs another revision for
> > other reasons, please include the information in the commit messages
> > then.
> >
> > The evaluation is done by an LLM so it may be wrong, if you think
> > that is the case please reply and explain.
>
> Found by Sashiko, not seen in production. I triggered the hang in a
> VM, with a test-only msleep() to widen the window. It does not hang
> with this patch.
>
> Regards
> Anil
