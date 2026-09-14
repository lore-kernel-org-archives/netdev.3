Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A543CE6D
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382477; cv=pass; b=jeRoCs9+FOldK0or+tQ6JKoJdYw0V81gOwNvkZYsShu9hGTjchKeGNbEthK9wkUUNdtIoA8pm4r8w8h0l3mIcB/fWfL4azLLNIgzcKMuZMSJRxwI84rQ/OLDCHACfexOA9jc2kRuZjl1AtgN+mlJRxEWcVXtGk37xFMYrcBhhzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382477; c=relaxed/simple;
	bh=iJOn1fIiQ2XA2NbGR5R+22xMoshBHH07wVpWChHZaPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgtyixRrG+JNd3PdOJ/4AfnJke0NmjMmp3teq2Z5axox2MqtbNS6mztPgR5/pIruwQFd4EtBSuVLzKbOctnW4nsqtTeqVtFisNI9rH1McssCSc45teynmUJYlyuPKuA0UvuEoGcZ6lTp7HI9RSNyUw1QdtrEdiSKLZdBe8EncYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KWD+j5yY; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KWD+j5yY"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5309ce58730so34104971cf.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 03:41:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789382473; cv=none;
        d=google.com; s=arc-20260327;
        b=Ex6DuBeQKwwZ0m0lhivrBSeJwt1s11lPR/3frYHFdWz5vgGThAdYotXmQpyKRSpl8v
         B9h3WtFNI7GAp4yvdw4NaU9LXYJJUWUo/JDCfDTbHvLkfDYcFMV6eGRaeGOQho3cwNb7
         DwRPZB+sPLm3F76piCj5X4pci7RF4IulSoaQKFaL7AwMg3vbPolcKgkPYSh8kBN1ktQv
         NzeJHCBsR2o280PCiANr/Z8UjQQVue+0SOS7juxwAaUW5x2QAWm6GcD+AOUdCCf/s6CS
         ddYyThcblhMHEqGy0BFkQlnNC5TT3J6GgZYT6tO77IwgX1dmf+4GeKH3YI/pcKO6rtFC
         7vlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iJOn1fIiQ2XA2NbGR5R+22xMoshBHH07wVpWChHZaPA=;
        fh=TNaQnSWvLJYyhfcolyackkM9JEtfVingXGW7C6BzIxc=;
        b=sVlY7sXSUIsw++aE3eqom80hYiOYpTtuPdFAQlU6T6RSJa1T4GkakmIycc62DsYhD2
         coQpIRDNnFJGTQ6wsvbfO5rD6FnEuWFslL2ekmVdTaIB55+2+vk01aboTbjgTWaObOIK
         Nxt8Boc8PHVlkGEZH1dze5/4d53qyHDoC0IQts75q+I+NPJGftbal3i3U+Cbj6/9/tjO
         x2pNxPpCDCQqnDZwtQHFHzG5zYNS9xrvluluzC5lcOe/uxfluFCQ5UbNJQ54X/09nVoU
         V9O353bf1hIq1FOYr8vzYCu4gbCrSrjIUkSc0rDcENb+WLzjv2ZPUP67Ixs3zlziyeF4
         Q+cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789382473; x=1789987273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iJOn1fIiQ2XA2NbGR5R+22xMoshBHH07wVpWChHZaPA=;
        b=KWD+j5yYSlLTfjh6B32lfapLcW1WLl5eR5RwpQSd4k5gd6M8a9mAfJOwod+FqhvzLE
         4JRVDnX11YIfdW54L+ZvOzyTlFJZOF7lpzKghB0Dpg78uoExI8Wv+srv3K0qNM/53Riu
         gmqooEuphLPD7EDxlqGoXGuEIeD+1VJD07FMbHnxvUhcSbKNzvP92rjO9wMz7DYssNza
         Du7+KelOOY8XnZIUlaTkdJ1AKH6Mne7SJN9ExlzSa+1mHAUTxyT7GcJj+zL3elIqkEc6
         z/B4NHeFrtV0mCGr4kXhHcxllc/nmB39LFYp8lIhWuMf1IZRqmMKc1N0JqtvRbCHOeHI
         DD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789382473; x=1789987273;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iJOn1fIiQ2XA2NbGR5R+22xMoshBHH07wVpWChHZaPA=;
        b=eA3nZi8LUIHlcd/aA2gvSe3E/nfOy13u/Hoy8WiKtTCK6zvOiliTNkMuGt25PKjshp
         MJim8//AL+meI09t+maPAHRFongd6ZJlSDq2REy/qLv6GXCtONuo+Eb8fBoeboGoaD0t
         qed1IYaG/LnnF80oA+CKm6wkOFpTOOhWP6nlWv6ZSP+aghBIAc0UvJvo2tiRY4NzDYAW
         7KmDe6AScKtqSYBlMaV0IVcXzB/+OW0fJZVUt9vp+oidyAtMvAlTKs39Xw/jK91YnnOh
         FZgtTCZrlRfkJQRXwp27CDmQnmrE1nCqdwy8HMFrw1h5Nuxuxv3mvCmntTc0S4leFifU
         lzQg==
X-Gm-Message-State: AFuF++lPcuWrDk69oK4btdPD0UvOoKb2eR1HFWYKPgHRsmF2+Uie9Hf1
	Rr0BcaSGtPmc+dbW2sNszAKPFLAZjo0BfmyEUFAjvRY++8WCBbwVi8A/lalMtEEpK8yJJG3keAE
	uK5v90+kSz+cV4lYzGmU0+UTKwdV8zSKjCDrOxZ4U
X-Gm-Gg: AYBFou2YvD1XrLKxczyqdMlzWkGKYgn6p6VrtSxliVlUvD1EwQbbuATJRhnU18FURJZ
	C6TtHMxtwKLO2l3QXHzyhLSSUNk66BbYG2kQAQ4gr3EYjl/bbZ4l2u+juDR/yBluX/hq0iLHtlV
	qnhY61hM7y7BTcBh6QiJtD4l1GDV2ZIrBXwepCI85y+zVHi4G+wG9MMj1gsrhlfosSB2/1Z2y0h
	3wsJUQZbXbfOQh8yd0x5d/HLWw1qoCFcpSgZQG/BF2aSF4rUtvogHsrgCbo9xlHmM/d2Stthr0E
	1FyS0LlXoT4W82pVDTH5t+5Q2QlAE7x/lFgulecq41OVS5MgjYy44FT2oz+blhH73Z3X+oW8qRZ
	x8BEnmKZc2dcvt26M/XGGmhXuVxrNsW1Xo/F0J96f/DJ0BBo9WfzTxPCrZTYkY3kdvmw=
X-Received: by 2002:ac8:570d:0:b0:530:db17:b1b1 with SMTP id
 d75a77b69052e-5310cf168e7mr26629401cf.8.1789382472521; Mon, 14 Sep 2026
 03:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914090408.1435080-1-inbal.lipshtat@mail.huji.ac.il> <20260914090408.1435080-3-inbal.lipshtat@mail.huji.ac.il>
In-Reply-To: <20260914090408.1435080-3-inbal.lipshtat@mail.huji.ac.il>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Sep 2026 03:41:01 -0700
X-Gm-Features: AcwNN1V9iDmM7PzpMeqDOMBzojVOrcgi4pfkAfg8icBKj7kbHhaBUk5wYJMY8oU
Message-ID: <CANn89iLQdNwzFw9UXNmTiGQ1ge_etUJWz2npXk32Hg2CA+zgyA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] selftests: net: packetdrill: test exclusion of
 old ACK from TCP fast path
To: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, amit.klein@mail.huji.ac.il
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 2:04=E2=80=AFAM Inbal Schussheim
<inbal.lipshtat@mail.huji.ac.il> wrote:
>
> Add a packetdrill test for an in-sequence data segment carrying an
> excessively old ACK.
>
> Verify that the segment falls through from the TCP fast path to the slow
> path, where the existing ACK validation rejects it and sends a challenge
> ACK. The payload is not accepted and RCV.NXT remains unchanged.
>
> Based on the reproducer from Commit 3d501dd326fb
> ("tcp: do not accept ACK of bytes we never sent").
>
> Signed-off-by: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>

Reviewed-by: Eric Dumazet <edumazet@google.com>
