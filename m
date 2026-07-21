Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC1B429822
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658744; cv=pass; b=LF7KXtkFOIGeWxOcwYiUAHIV/u3gqEQhB/0FTWeiTLcaV1+/QstVayKlGpdO47O2dMWU4QEVYzUTjg4mjnoJv0Xtr0H+2ZmE/2+1NYR7ZHukfV4A7cUiXyYBf/9ar3bWFLlb7P98cTCjNvjlc1eJ6dK9iiMsBrK8f6SvAVuSwuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658744; c=relaxed/simple;
	bh=pXRAohn7fhmA6Dij+Rs6C43N6dNdrN7Dx/qYu5pat3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpRKwzQFJ9ZvfhuVCdJqMaIl9Owi0nWhnAe/ZKRiQK8dt8E459yxASu5Hpi73bmf0ayZJj8gX7vCCoaRJetRfj82LAul6nXJkk6k49hhTkarGHNPF7XmOwvW+E/BJRZ8zQpjo+Qxsvu1lI4P1g6wW8CrnXHG/0aYC/y6Jcjnulc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpXRARSj; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpXRARSj"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8edda5d56a5so127432906d6.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 11:32:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784658741; cv=none;
        d=google.com; s=arc-20260327;
        b=XsvR1D/ApNaGEEPzrAMjToDcyx7LqhRvlSn7SmK9hJMmM32bb10941UfRR8kas9L8T
         04YkfSHG9S88N+O1u7v8WbWQepqEcATpfS2vcUdmwbE7774iBoK6wzQaZ+dUQwSolbhI
         DmhGdYFnpusnHqZa0BfM6cOiZfvHGi1+0gsrlkU/h5hBqKkGqvFVpkYvaOWezoE2eR6N
         hqaHfHmUvN9wpGjbD2+KSJkuzgs3AXDIp9Zu6IhmqetkpiMoEDCmgQbsMa+tYtpVGT0V
         8QjVwkfgv6q4E85EUBdWpVBbVbtrkmB00Bi7oWmU3Ggs3gVCxbsAjkW5KqxWe/tQb0E3
         quEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C1MJtkN0nehJ3yvYgNvq0Vp+/NxQaXb3Gjx9oriv2pk=;
        fh=rMYmLTtMIDaADQWWOIhm/kYVyElDnQ6/B0WejfQWMQg=;
        b=B9Y+y6neZti4WeeLSL/Djf4f+T4ZiiQ1GxOH3muAIpGVH+tPXFaXKIXH+s+xUvwc/s
         zxbBnAbY4nSuXlBYOZLanogXZnOBL/5EH/3LHyCp6WMaezeqWq0HjVs7iJ9dSSLqdl3L
         Q3j+GqPqeF8caNdY0AUhHoqI3RyauIUKW0/KbqZDnrvELq71UMGVNwxeWCnlbedhJftx
         NIUI5zxmv5ReLo2f/9yxTHHzwBXkMje6ENzSKHxIIE2vwH9zSLs4H9iL/XBfAwPjZfRc
         Uh+NYF+NAJ2TPr1jY+DhGNfMRCVygENVRHwrAS9u6pWNL//D7JgUEMCii8CjjwH1su/b
         Nv0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784658741; x=1785263541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C1MJtkN0nehJ3yvYgNvq0Vp+/NxQaXb3Gjx9oriv2pk=;
        b=HpXRARSj87DIPBBKzQucuG9wjx29zBbSWB1hVHKPB0VEStBVRuz175U+6d1BvWdDR7
         AksUfiUIykOmMoH0KJ0NGHJ3WEXBbYdBsNX1Hsn1mXF/EZpNw6mPFAwHIaDdmnp30Sf6
         VoQNBNA4Ka/z/EiyhgJN5HzLcDEO38S2qtBk9Q1T+dKmOQI/w5vGiT4SOUb/FPrK/u1V
         TYPWPBSl6q2k1+njnK2OH6tQrqJuOlZ+I0YYpkxKis6emhoBnnk4fTjPVFRcREqgMEOl
         FAMTqiPmrtr0op0L47LStBvQh4XUzrPKEo81jJNuXHm+lB43qdzcWCSKt+IHcqGObMTC
         0c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784658741; x=1785263541;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1MJtkN0nehJ3yvYgNvq0Vp+/NxQaXb3Gjx9oriv2pk=;
        b=j5k3ZSRIYmQ8RVqDSFEbL2d6FUIheVxgo5nRpD3yy4nLn41DbBHd1ACLBhnV1x95og
         4mv9j2skzOalF0Rc8NZBhmHY1Kk0AkvKR05PUt4NI+Nwm0gXYhzw7MtjH/uChEL7Zgub
         IVrz32EvgcGC9bOFz8tAVM/wu8I0BUWpd5xRxxgKk84XmX40z0HM3TuevRDN9AGyfQeA
         FwRDVUarm5wmgxsztrXjyGK3zxgnavnPXgKcIJ2VoSdvAGInToHDplP6i6/o+QuzjdhL
         2lrdphaGJony5tK0XgRU69sjYvWuNIe5E8vU4k4waEJXIHiEkQiCBfjcoclBrZMVU9iZ
         AWHA==
X-Forwarded-Encrypted: i=1; AHgh+RrHVVoQPdrR0IeEA6cBle9FmagUPops8jeR7ZAt6F9/U9dk4hGxMHObMMNCoEoxE7ivoMldNMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/lUfzMS6jhTQonKC0ozmTjFMYTJWe94YY5ykwfAJyMCYAXPD
	zS1vAELx5auB7VemdaJuVqF04lLuS0N0lqmj4pXJtdT8CI6vYXHXaYBfCso29XumBvdjG1gbF8n
	uWnRL2Yp3PA/KFzYTPXZpRlwnnDzNXoE=
X-Gm-Gg: AfdE7cnGEZ/IBM+uxaRPT/QOG5UR9s6OGwShpto1tRt2lFT7AQwpRfE3YV6XP8VgA3v
	Pje60qHVbHbL+BZN/G57Vs4nC0MlCpUYy75PwCipxc9e+3oOZzIn4emCM1TnDYcQLa8px19Se5k
	qv9UQ4Eskk64wHV94BOCe+0JNHWO2N3IwPve0YeU43AZG+MSIjXHc7zfcZDk1BEsWkaWWpZJ7JQ
	6FMC3HDknGnd/PsqhsTv6Ac2lBD8HiObN3SSW3DP3oqbUjnXLceSdKZGFnGflv/ZseA+ZbH6xKW
	wNjZMZNiUSmTuybsqiuL7WPaMP5fnA==
X-Received: by 2002:a05:620a:230d:10b0:92b:6805:91b5 with SMTP id
 af79cd13be357-930b431be08mr1496071185a.61.1784658741250; Tue, 21 Jul 2026
 11:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721163632.1570651-1-bestswngs@gmail.com> <7fd2e4f3-ccfe-4e09-8f24-8dcf89b4774d@gmail.com>
In-Reply-To: <7fd2e4f3-ccfe-4e09-8f24-8dcf89b4774d@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Wed, 22 Jul 2026 02:31:43 +0800
X-Gm-Features: AUfX_mysdVcTo5mL3CVBmInuSwRquedeczs8l23QWYhaq4WaV5snxVToh2OAxNE
Message-ID: <CANgPUi2kAZUwJ7XMw7VgX3gPrakqaePOqk-Q8RxCq8HBar3cdg@mail.gmail.com>
Subject: Re: [PATCH net-next] nfc: digital: fix use-after-free in nfc_digital_unregister_device()
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Daniel Zahka <daniel.zahka@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=B8=89 02:07=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 7/21/26 12:36 PM, Weiming Shi wrote:
> > nfc_digital_unregister_device() cancels cmd_work and cmd_complete_work
> > once each and then frees the command queue.  The two works re-arm each
> > other: digital_wq_cmd_complete() ends with schedule_work(&ddev->cmd_wor=
k),
> > and digital_wq_cmd() hands a command to the driver whose asynchronous
> > completion schedules cmd_complete_work.  cancel_work_sync() only waits =
for
> > the instance it cancels; it does not stop the work from being queued ag=
ain.
> > A work re-armed after its cancel_work_sync() therefore runs concurrentl=
y
> > with the cmd_queue cleanup and dereferences a digital_cmd the cleanup h=
as
> > already freed.  digital_wq_cmd() widens the window by dropping cmd_lock
> > before using the command it took from the queue, while the cleanup loop
> > frees the commands without holding cmd_lock.
> >
> > It is reproducible with the software NFC simulator (CONFIG_NFC_SIM): st=
art
> > an NFC-DEP exchange between the two nfcsim devices and unload the modul=
e
> > while it is running.
> >
> >   BUG: KASAN: slab-use-after-free in digital_wq_cmd (net/nfc/digital_co=
re.c:174)
> >   Read of size 1 by task kworker/1:5
> >   Workqueue: events digital_wq_cmd
> >    digital_wq_cmd (net/nfc/digital_core.c:174)
> >    process_one_work
> >    worker_thread
> >    kthread
> >
> >   Allocated by task 5124:
> >    digital_send_cmd (net/nfc/digital_core.c:234)
> >    digital_in_send_sdd_req
> >    digital_in_recv_sens_res
> >    digital_wq_cmd_complete (net/nfc/digital_core.c:134)
> >
> >   Freed by task 4994:
> >    kfree
> >    nfc_digital_unregister_device (net/nfc/digital_core.c:859)
> >    nfcsim_device_free [nfcsim]
> >    nfcsim_exit [nfcsim]
> >    __do_sys_delete_module
> >
> > Use disable_work_sync() instead of cancel_work_sync() for the two comma=
nd
> > works.  disable_work_sync() cancels the work and disables it, so any la=
ter
> > schedule_work() -- whether from the sibling work re-arming it or from t=
he
> > driver's completion callback -- becomes a no-op.  Once both works are
> > disabled no work can run, and the cleanup loop frees the queue with no =
work
> > able to reach a freed command.
> >
> > Fixes: 59ee2361c924 ("NFC Digital: Implement driver commands mechanism"=
)
>
> Fix for this commit should target the net tree instead of net-next.
>
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >   net/nfc/digital_core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/nfc/digital_core.c b/net/nfc/digital_core.c
> > index 7cb1e6aaae90..6def5132a4a6 100644
> > --- a/net/nfc/digital_core.c
> > +++ b/net/nfc/digital_core.c
> > @@ -843,8 +843,8 @@ void nfc_digital_unregister_device(struct nfc_digit=
al_dev *ddev)
> >       mutex_unlock(&ddev->poll_lock);
> >
> >       cancel_delayed_work_sync(&ddev->poll_work);
> > -     cancel_work_sync(&ddev->cmd_work);
> > -     cancel_work_sync(&ddev->cmd_complete_work);
> > +     disable_work_sync(&ddev->cmd_work);
> > +     disable_work_sync(&ddev->cmd_complete_work);
> >
> >       list_for_each_entry_safe(cmd, n, &ddev->cmd_queue, queue) {
> >               list_del(&cmd->queue);
> >
> > base-commit: d4932951a19a5f1ec93200260b85e1a4c080ff77
>

Thanks, will resend as v2 against net.
