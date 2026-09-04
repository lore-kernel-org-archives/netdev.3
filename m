Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43550EBE6
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541671; cv=none; b=qsks8CgIu5mqsms+hU7WUBgV5WNHZu8ECli7KPhb8OlWmegbBfQ0K+8NvrDpbj1ZNzI6nbpGQ6KI+f1TIpfsQ49S+nzfsOaZv5dA9d3vSjCnlbBJcLT2WcpI4nSQ3uopS0wbshbWLP9GMgm4cnRiDkKkQlKqPv1/pf3X+druc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541671; c=relaxed/simple;
	bh=R2iMVpGxciRBsYsoGuCGIL3TC/C/mpSckDkgVumUDjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B7QsMAF6B8PCn6sx2xu7LNnnL6I3oxh27ZWL3SycU+pQeYaT3dTHHDMoVYf1I9I/LzhKIJJ2t73D1LpgDh4Ey3MSQ8ezRLFQWccH4KKafwiTahobzyvRn5HgRQt1gy0C3F3DOpbyYmEx7vhfYd3sb4h7h8oWB5yqD36lbxRDrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyleVI8k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tI/RGOok; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyleVI8k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tI/RGOok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788541668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4p/TXWN5TTjU8Fhqa3oiMoIW3DoEVRHu2RLVaJn1QpY=;
	b=hyleVI8koWrIY9URD11VMmbF4fVll1wGyka2oX1dl9FeSWKn/o1tY3SMeCHdx6RcbmmN3D
	y+/1HDtff+RB34DuC224f4LVPpdp6Nl1p6dm0g3Qet/f3b/CzIw2tJ/eAyWsYEeVSikgyp
	lYM0k0aPx/9/7Z+s5aWJKviizhIV0ys=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477--OSCXHsyOwyLWn0KZIG16w-1; Fri, 04 Sep 2026 13:07:47 -0400
X-MC-Unique: -OSCXHsyOwyLWn0KZIG16w-1
X-Mimecast-MFC-AGG-ID: -OSCXHsyOwyLWn0KZIG16w_1788541667
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936aa34873bso170037285a.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788541667; x=1789146467; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4p/TXWN5TTjU8Fhqa3oiMoIW3DoEVRHu2RLVaJn1QpY=;
        b=tI/RGOokzUq3a6soCNl1t0tcxLttFU2HmO7I9TI+oZ7H226gKy9JF9sIvxWV5/PSIy
         eyJ/mmwDn2F0ahVVvhIEf8orXmDyQDVIhBcxBToBRH+XChuHgl9lLdN/oAZ6UOJp2EL3
         j2QLwJ8tx4rkUq+1URGkgpp8LSA76A+9DMq/HVTZ93i7so54fcAqL+Tzc/KOWrD6KExR
         SvhS4X1S89J2WfiWTfObxP1flLtQcSrw+viLLacPLoGG3E9CnV7uzHfUHh6uWAy+Anli
         UjEXa20oz/PmGNFklka2TygdVfGzdJPCFHx+0zJSk9HJwhPlt6/cRDxev4lrdKr1ayid
         PC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788541667; x=1789146467;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4p/TXWN5TTjU8Fhqa3oiMoIW3DoEVRHu2RLVaJn1QpY=;
        b=CWPyxow5LlN9LJLksxVpIRlpHYoflhDl29MYSYz8bGU01PHnu1HNjYp+XWQCD5LlSA
         byq5TsPy2q9YNEB0aA1sUVXABD8aJvq/89RB370++H6vJ7STNJAFcNSeiVZ7fr+42ATK
         YqM1sbM5jK5mCfot2AuJg/Bk08N7UYrO2N4Mg6BliN2nNq+ld3LCP1FtpAyluFpAVifO
         sS5gZ/FXb9X33RK+Fg5dq8yyNxxwE2KUkaRCkhHWB7c9JCk5Ty5OLGsn7jQqCa6xWxm/
         x71BBVem/cYTOitLQ4d4zHOkWzcEcfZI5Bwm7pHAbDA5pPz3yEcZOHe6V2u2di0EYgMb
         R47w==
X-Gm-Message-State: AFuF++mLK9lPhBn3ELQy/TMM+2g8BqFoDSKzEK0USx7/NgPeDFx+fv9W
	p8OhK9yehCC1ApZDDhCY9WjEDnrA3zhzxstSwvHN1v6/HRQN6FXSwyT0sEdgx6zeB9BnyJc9xW3
	CNkY8ifFIphGrYkY6pfHEbeF8csS15Tne4zaHSgYNln3FjtqpL2bwEmo0yMew3sze8Yng
X-Gm-Gg: AYBFou0oHsl39FtE5lWw37NvLqlGTHeqZw07Ys7AF6FLt7F9NRCs2sjTNJEg4w5Q9hp
	DnNIOKgJeBBmZCdzRu1pos1RXSoSe01DgIytpwnRP42Mw6wb05Xtldv70N4HwIiK9b4jSoJ0PIe
	qhzANRTB+Ba7T4vY781Ige348hBHTNw0ZBTDl958rQ3A4RE89n9pvDaNZ/pE0ul19oCsIH1e4bn
	23igE3YdLotQkZhXETsHe7BORcjtLKRrsMtaGb0HDVfOrTgxltOk5RKEJl27o2TQuv/RMCeZgsN
	+iP2CuEgLOh36zGPeK5An3OH+gwAB1CkW2mBfsth6eNjKLX7holkPCK2h7USsftH3vIfGtDHl81
	qpXhAZex9UHzA3fnEqXvp14lcgReR
X-Received: by 2002:a05:620a:38ca:b0:939:72ae:e536 with SMTP id af79cd13be357-9398033d47fmr456393885a.13.1788541662024;
        Fri, 04 Sep 2026 10:07:42 -0700 (PDT)
X-Received: by 2002:a05:620a:38ca:b0:939:72ae:e536 with SMTP id af79cd13be357-9398033d47fmr456390385a.13.1788541661512;
        Fri, 04 Sep 2026 10:07:41 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbb70f1sm260910885a.40.2026.09.04.10.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 10:07:40 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  dev@openvswitch.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: openvswitch: don't schedule rebalancing
 if there are no datapaths
In-Reply-To: <20260902203200.1416026-1-i.maximets@ovn.org> (Ilya Maximets's
	message of "Wed, 2 Sep 2026 22:30:41 +0200")
References: <20260902203200.1416026-1-i.maximets@ovn.org>
Date: Fri, 04 Sep 2026 13:07:39 -0400
Message-ID: <f7ta4pxj678.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ilya Maximets <i.maximets@ovn.org> writes:

> During namespace initialization the masks rebalancing work is
> scheduled and automatically re-scheduled every 4 seconds afterwards.
> This is happening in every namespace.  On a large kubernetes node with
> 500 pods, i.e., 500+ namespaces, this creates a decent amount of
> unnecessary churn scheduling 500 jobs every 4 seconds that take the
> mutex, check that there are no datapaths in their namespace, release
> the mutex, re-schedule themselves and exit.  These 500 unnecessary
> mutex locks may hold off operations in a single namespace that
> actually has a datapath configured and has real user requests to
> handle under this lock.  They can also add delay to removal of other
> namespaces as ovs_exit_net() needs to take that lock as well and
> synchronously waits for the work to be cancelled.
>
> Let's only fire the job when the first datapath is actually created
> and not re-arm it if there are no more datapaths configured in the
> namespace.
>
> Another approach would be to make ovs_mutex per-namespace, but it's
> a much larger change that should be handled separately, and the
> unnecessary work scheduling feels like a waste regardless.
>
> It's safe to check and re-arm outside of the mutex as DP_CMD_NEW
> handler will re-arm if the new datapath appears.  The scheduling
> attempt also doesn't change the work or delay if it is already queued,
> so it's also safe to call multiple times.
>
> Skipping the re-arming is more elegant than canceling on removal of
> the last datapath as it allows us to not think about potential race
> conditions at a negligible cost of potentially one extra re-scheduling.
>
> msecs_to_jiffies() moved to the macro to save on line length.
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

