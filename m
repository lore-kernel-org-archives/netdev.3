Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867184189D7
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296608; cv=pass; b=gVBph3zm67AFxlasV0+49QfD4l4Vox0DG68CrExBmKvn19JEnK7izvXXzlVmK5OKShe1XpQzmCWVz8fX9kg9zDIaDp9pvtyOxaNVqt6nBSX9RQG36c5y0Pu8jrF3D5knKSMDmMHY2PSfY1C62tqOjXgi+2pYQ7cZ2/Zg6JWFN8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296608; c=relaxed/simple;
	bh=ErvyfkwfekuvkUJ0WW3upoWBqOO+tdHfRz+KHfX7g8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdS7cPrKe3XiRifoH6oAtQHxTLP5ZqlL1VOcv7FKkWWyJyax5sVYi5Fmy1Uml2gIhDfavfxa1mu38UiYnNND8cl03ddijkXRnHizXQXuiQOY/Sb2lx6sa2hTWWqK0k/5yzGdPRzMXDzsLIcIOtnF5gymac+wAPgbZAPnHjn2fiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJZdjMEZ; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJZdjMEZ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c74722e27so20244391fa.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784296604; cv=none;
        d=google.com; s=arc-20260327;
        b=oCaPAzZ+x7UR1YTr2N3JYiKw73Uc/Z4Z+yWbjPP1exeyvitEv42HARaB9BPQIApu8a
         GV8G8MTRfV0Jey6MKoyEjbx6tR1ZVkx5Hhkb8WyYH9IJOp961KjXnCWtUP1rSX+MlL/1
         DyLD6T+va82wsdUux31jz0aii9ITgljRXNZI+VUJpCEP89xkCU0mWepRuyNVX8a7EF4w
         h30cPZa59AtAVxU69z9/XBVB3o0sEUpM2roI7JemZjrx1NU6Urovcblu73Jz3sR/M13d
         BY3T1LKRS4bFr70XFkcfX5LJJIuPKA2E7f+5Hq3xDR7Mm1j8J61H6jjC2+jJ1aQeiXLT
         aK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ErvyfkwfekuvkUJ0WW3upoWBqOO+tdHfRz+KHfX7g8E=;
        fh=JI3h9u+zcTfgqfsrvii+M2LwYW6m91hHHyR7PjAVQZI=;
        b=JU1BSoi5srM3Ko/Ax2NwovUmq2VgF9phufV/ZzXXgI6pYWlYOsBqzdd9PGoy2BEk9M
         SlNCffa3wCiYilDu84yqaEpPUUWAdq9lzuybgVDHb4isbNWwh9rGcm90NNrOLLyQcgVd
         aawacVWrZXXjCPKYSn0jV5w1VCXcL1z4tcHQcKLJ6khbq4JAu79k56TQfWSSpqT26s4r
         6PJw9BVCKikIGCwTzVmD5hQFxWMrlMpurqosStVlL/m60NvoDoXDsP6kQrrpOuBf440e
         olwBYQUqZCRP28nGYZxapNYwJdwi8ays0gdOfGtOPqXZxAoPPa79us8BCY9SHsO7eacd
         OY7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784296604; x=1784901404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ErvyfkwfekuvkUJ0WW3upoWBqOO+tdHfRz+KHfX7g8E=;
        b=kJZdjMEZtlIN+5CvZD9TiW7lcN8dI9iwlAvPRDjj2SuTHAzOPQ8ovdaOh5/ONvGQSg
         9TQGYKj5IB5/Dyu/MI1L9URCAiVevQ4O3O24MsU65xjxpB1buzlrmgb0x5vog+vwzL41
         ca0XD6usio+KqT7ofVZ0rwnOfSHbh+DWj1HWNBeZ+liNWpXua+Iz6njE2LpwWP2nxLXz
         MP8LCMQ+v7cWiwF1lD2/Ao3YaGAMbeC3P+GAgFCWR9IK6EnMjSCxlmVza+zT+Jr8YHT+
         BupbLF7oM6/rnx58ZpX2IxJAHCDXyWsbMielAjPxsLGJuN3uL+yM8qfypK0q9cCO26OQ
         8eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784296604; x=1784901404;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ErvyfkwfekuvkUJ0WW3upoWBqOO+tdHfRz+KHfX7g8E=;
        b=MnB8ytWsShUSnIno0HoWYmV3S+KJNJTQI3bzHNCxz9lr68HOZ7+17zB4E9dFYX7C6H
         jr1ZPw4ZK7ERIHD64KbdQCcC9Bw3q9Qj0UMt55XSnefTDOUOaxvSzR7mCeoSm+tVa1hJ
         4wZ9MlbUDEg//VIS/YOFFW7JC90Ripv3sWDr217bZkqGQuhdRKIeTp9neo5SgPhTzTOQ
         7h8qQJ32Ci6Eydp98aEGJIQLVp/pEHhK+6PO+GuERw3692+Fvs/9eL5sRX7dH/zlXXt3
         1JZGgkpH9h86f1UsmZz7gleRpy1UOVz+WVxQvm67xKQZ6+C8Ezm2rmfZVd84bnjW/ZFD
         6VXw==
X-Gm-Message-State: AOJu0YxnwnwyOjOEVs8FA90BrYLuOYmDM5EvewrP83PSEtIdDYAUk5Zs
	aEPnjS0ED6JuEIelU3JaAzOQv5cUoiPYipO8W0BgQYgrfhXvqEWPS9T8ZjtTxqBhhPC9d1x2/41
	XQdIkJdtFKf3mkVNgQK3juZ8fDPc/b3k=
X-Gm-Gg: AfdE7clknHHCJ0glxm4x0I7+P7ldHKjdihHXHxFb+lfWd3GaCR7eVtTOiJ7ZCvMsqrg
	/7Ofbvy6xKB3ikebNmu68G/DF04QCdReQ0U3sXgeJQlTmVaHOzGT0/Vd8uA6xbfnRHnOQA9XRQQ
	ByvUeVdXNgbcQ9D3r4fgr2+S3TU61Yd4jdlKG3Fi88p9F+qynRvhBVJxKsILtmHYsJOp5ysVus/
	4g3hvUz9Doyl34bFQLWF0yHaUfSSG2HlxQ6tSxaEAGg7mbvh9JFydZNXsxmhXMjh3UWG5HUbpy2
	/uhUdGGtgulUwyvMmfnA2ZCJZkx7l0MXq0zoY5hmETiaXAcXhYVF4EMgS+GGo1J8qoVeOcD/dtU
	/3dXPbJKA3YimknrlUBD/dw==
X-Received: by 2002:a2e:9584:0:b0:39c:a0a2:fe70 with SMTP id
 38308e7fff4ca-39e9fe04a88mr8262121fa.8.1784296604244; Fri, 17 Jul 2026
 06:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com> <20260714140722.111645-6-maciej.fijalkowski@intel.com>
In-Reply-To: <20260714140722.111645-6-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 17 Jul 2026 15:56:04 +0200
X-Gm-Features: AUfX_mz82S5i-jqJDTI8fVjpB6bjNQ3HZ8tw-PF3v6beC2MyccVw3Ymh1QUuMas
Message-ID: <CAL+tcoBsV4T0adG7DWpzVoMij8o707HMGp9w1f_g-Ot5qKhrfg@mail.gmail.com>
Subject: Re: [PATCH v3 net 5/6] selftests/xsk: fix too-many-frags multi-buffer
 Tx test
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:08=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> The too-many-frags test describes a packet that is valid from the Tx
> ring ownership point of view, but invalid for transmission because it
> exceeds the supported number of fragments.
>
> Keep the generated Tx descriptors valid so that __send_pkts() accounts
> them as outstanding descriptors that must be reclaimed through the CQ.
> Then mark the corresponding Rx packet invalid so the test still does
> not expect the oversized packet to appear on the receive side.
>
> Add a valid synchronization packet after the oversized packet so the
> test can verify that the Tx path drains the bad packet and resumes at
> the next packet boundary.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
