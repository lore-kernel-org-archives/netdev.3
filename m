Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3E74248B3
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208724; cv=pass; b=Qi6sJVhbaUFngMyeCDFjtPRPmDGk/3+ph+fAVbXVqOEPvivF/2vb/z2wYdAtMoml6SnGElpjTqhoJMJIMqtjv/fdmYkXWyodpArypyAHDq1lOxuIZhVkXo7ch8tHcxOLPMdOTHO+/DR35GcyR+U1+QZAfA7T7UyLveD+uOkAWUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208724; c=relaxed/simple;
	bh=WUOL/WHziYXuwjEH8wV6S0ndVw9mg6KTRcK5kUefc80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVYGq4wuOzpg0VBU6/QBSHiTVzfJaYJsjaIqRLdd1ncujKVdyIaswE21umG2S5koVDgv2F2BzDZ8tZne8qyrqcWs16W0S68zN2ELANsb/8+w9WI6HqIR8a2mHQEBiw8zPQdkGFTNQCvaKizZGmuDeOcq5Lvk8FF4YD9z52e8QHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9/AcyAE; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9/AcyAE"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so589935b3a.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784208722; cv=none;
        d=google.com; s=arc-20260327;
        b=npD63oF8SF7VoRdqh1lTAF4oKHXhpq2H8Y0aMKGjCD0yHDV7tDF6QakGkNe9M/9JpP
         bmpqjdIWy4T3nCcCSJ5lrBN/UaiU6Fy24e8YTvwRYUPP6mIISW7AqRVLwl2rIpOmA8BU
         J44g11xmDV43wXQT34/riLeHwp5hnY5i5mVydDFuYk61GX7QARf2IUctzxUXNKjAF/4v
         mPqcw3SwAh3ZH3h3r3UhSYDv96Dpaw0tR0/c69Ror8E9w0mwv+qd2Mp0MW9N9onEZ4eF
         Fv6j3BlBbMDJxi0A3Vqees2xL5lp2sDdpFjeF/8Ub8r2We8hGeFxPvURm0JVex33JOnG
         FXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uGHHs+3P3MchxCub/aaBCj8RgZEQL9E4cXnFGeoA6bg=;
        fh=xbmBnLrFPN6d4Q5gIF4vNntZebTtp5xTUpvmba8rPtU=;
        b=Qyghmyivun+Fw/WWGt6scfRy/tO58wg5T+/gP36vaTAdOvEmZCW4GTl2b1K8a2Nsbx
         6pIePrAIsklTS8lJ/FWHy52VoV+qTHzfNNO0i91yHAtgEHCbMsrgtGr/4Z5qsTyMaIyv
         yqNZM6UA0QL3hysD5YXCj7+vEV/3nofV84R8Y13AAVKQBuKGUsQifJylraeYz4Qea9CD
         VrSixz8/UzuMfCEVnuCOhDJECStWjAOPOD0NxOELiwyRfV7U1s48C/1V+TMiH0r5nxtP
         LbVYJ6K2sZnMcj/aG5sftVPuIHk8Ku0ijUpBTBttSOF9kdCDWGlwlEnKgKa0+94XzSgQ
         Bg0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784208722; x=1784813522; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uGHHs+3P3MchxCub/aaBCj8RgZEQL9E4cXnFGeoA6bg=;
        b=K9/AcyAEB1Q14M4Pe6qjpaNzcqri01mYzFB/483wa6QuDPEssRteeDeU423K3sF9Rv
         m5EH35S3RygviApYJmnS8sqgzBhxj+NP5H/brmtB08RW45KTC5K5mit01hYE8BDS9xYR
         fPdntY1BPl/Mwf4Rq+jMWnEP4+tgxLYf9vqRajfpa1kzP+SYeiMrisu4jMWDfTE2sBoW
         Pg1dNbwuX6siRHrrjj/lCIwwHIFsLKBXHhc7ZntsmqCqgDp0L4Zz7WPitn6H0B8MumyY
         CocvTzmIoA5CZ/XB+BIlK8lZU9UeD9HUqV8l8NVbgCmlSQLBFI3ClZxvQWcsAizT0hes
         wHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208722; x=1784813522;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uGHHs+3P3MchxCub/aaBCj8RgZEQL9E4cXnFGeoA6bg=;
        b=H/wiPPbKTGTzNqpPwRlc7lUEKL2vSB1YpW5Vhur0lovbqBgI0gnYdjHrsWRpysv2wP
         yT/DaJ7JUTDOl38ci2m9QAlHmoHdS+frG/t/zueXV93YW/J4ZeylPYKks6dgcZ8qWxeQ
         5moByn6CERby6y+f1HATtbJvrcQzlIc8Tr4q5vznczgU4rTQpz4jRS9ioG3SO87p5lCw
         6seHcvlsy35aAJ+SosgHWXCHWaB74iPf50hmsTzVeGxekFWoLTFqH6c4MhUaydhxvrOK
         JFmf/l7u5MI+RU9ZgB4mCnwvf8Dbjt62fhaY86Ep9tQKuEzAwYTmpMiszKN6TsKcFRDu
         ZDMw==
X-Forwarded-Encrypted: i=1; AHgh+RoQbGeo0ewJVGVFUPi0m1FS9Tsm/SL0vwucujUV/GOuS7cTQOMO/BGmehJflHl2VMLqMcdBAm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNFSnOj9S07ACPaWYckQF48yqqPRE5luZfx/Wdu5FMnycxsEVp
	UuHxJ1Jac3bfPvaO8i3OEnr2H0+IovM+5eONfUSUJra/DOHzIdWE2dVaYatGkI3KhmVxR8Ng/cE
	gL6WhIqlU85w9TdYz0WndJ00cq8ZBXbU=
X-Gm-Gg: AfdE7cn36Smh81al2kUldMUtHoDqbi83OhrQ8QMUf9si8DH0t8ff3sTYcqjj7SOay1D
	J4G0bNMMlHKTwYv+cXTv1ZQdTBhtCI1Yj39a9EEerkB7oe9DGZimm16kVXxQ7UdscZmetteRePL
	4IcFm7e0uxDibP6n9I6Z4TVrFOh8aXRSuo3I+XBwtSTICSypY6iJ81lHjrTEGvE8lnc389LbkBP
	BgbSuCK3kQohqy9EYnX1TFLtTCevnjJWFJ3C771Icj14VrtxN0vKXFnVtVCdwULJoVqRff+Z7w6
	g2eYPxS0SVSs5q52KrkfVhMSfsB4cqllTGoSh5tTEoZSrJIqbbQXpqBa/gBj0BGcN95xrJJH6lY
	D152XtvJ4XSZYq03oMQ==
X-Received: by 2002:a05:6a00:3395:b0:84c:145e:16b9 with SMTP id
 d2e1a72fcca58-84c145e1962mr1192249b3a.18.1784208721955; Thu, 16 Jul 2026
 06:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784033357.git.roxy520tt@gmail.com> <6dab75f22855cb219e2e30a5497cab03b970ab91.1784033357.git.roxy520tt@gmail.com>
In-Reply-To: <6dab75f22855cb219e2e30a5497cab03b970ab91.1784033357.git.roxy520tt@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 16 Jul 2026 09:31:49 -0400
X-Gm-Features: AUfX_mwOBQMoPqGjbTFM1fZ1OwpwLVzxnWM0VPUPUABy_qo90EifY-WiIpJMFQw
Message-ID: <CADvbK_c7ZimrdY=yf+7jGzLTN6ZOT+-4_LzQxAg9-fEostzDtQ@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] sctp: close UDP tunnel sockets during netns teardown
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn, 
	tpluszz77@gmail.com, roxy520tt@gmail.com, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 9:51=E2=80=AFPM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Zhiling Zou <roxy520tt@gmail.com>
>
> proc_sctp_do_udp_port() starts per-net SCTP UDP tunneling sockets when
> net.sctp.udp_port is set, and stops/restarts them when the sysctl value
> changes. The netns exit path does not stop these sockets, so a namespace
> can be torn down while its SCTP UDP tunnel sockets are still installed.
>
> Close the UDP tunnel sockets from sctp_ctrlsock_exit() after unregisterin=
g
> the per-net sysctl table. This prevents new sysctl writes from racing in
> while the sockets are being released, and closes the sockets before the
> control socket is destroyed.
>
> Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/b9f1f02b0780ad6a719e2413f5f0bb8eb7=
702d94.1782585631.git.roxy520tt%40gmail.com
> Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> Changes in v3:
> - No code changes.
>
>  net/sctp/protocol.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index 49d9740b1e0f..27c26e12f95d 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -1460,6 +1460,7 @@ static int __net_init sctp_ctrlsock_init(struct net=
 *net)
>  static void __net_exit sctp_ctrlsock_exit(struct net *net)
>  {
>         sctp_sysctl_net_unregister(net);
> +       sctp_udp_sock_stop(net);
>
>         /* Free the control endpoint.  */
>         inet_ctl_sock_destroy(net->sctp.ctl_sock);
> --
> 2.43.0
>
Acked-by: Xin Long <lucien.xin@gmail.com>
