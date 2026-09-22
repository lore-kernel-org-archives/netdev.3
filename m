Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BEF559CB3
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090796; cv=none; b=royMA9e5MLJ5OGSIC9LY8h8RUbXE/6jV1iQtLhvD4pdyjBXl1ggEUPVWZO+59QaxRgczDg3IMBRdcuSUcXhjyWWFzMLkXnjj0ZkSOVqILPYR5v25mLJHDCQFqh1DiGC5Gu2vjaANyxiDj/Fp68ix10GBgmgQ94sc8TGC80QywqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090796; c=relaxed/simple;
	bh=4tTfIyxQFrJO0eYjaziEFGFnUgNWltKT23dBmntSrLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SPKHZAJBPX3zFjZqBkPGWT24m2ccS08p7pDtkhJYe0AtyJ1y3h0vY99FKuj3Bfp6pfxMi2+WZ+BooNwII0rdgL2go++iBha4wcGKJeehlBkITAIrdb5SqUxlzNNKE/hiR0qLTA+VPA+qF1iR9TQmk383TNaPiCe/w6Sufe1j6kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WI6mzsW7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dg5AaW+c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WI6mzsW7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dg5AaW+c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790090792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/8zY26QjQrdL1DZs1bTzu+yz0u+JYpgALxi7/8nmtuE=;
	b=WI6mzsW7VYM2PFs2Ss7PJ/Xw5+sgsKE/5yosyB02GgtCvYPczNOIrzY8OzwC9WWUvA9jAZ
	37DjifYIZ+oYE3KxEFtp/L/gxULKycZBiJijf/U0bXEIa+qWqXoeqKG2FNmkU3izfVfOTn
	/61FX2QQIXpTB5g/AjT31VISwpo0rHI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-GOoLYIuyOVepZu7T56X9Nw-1; Tue, 22 Sep 2026 11:26:31 -0400
X-MC-Unique: GOoLYIuyOVepZu7T56X9Nw-1
X-Mimecast-MFC-AGG-ID: GOoLYIuyOVepZu7T56X9Nw_1790090790
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cf9df1eadso37942005e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790090790; x=1790695590; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/8zY26QjQrdL1DZs1bTzu+yz0u+JYpgALxi7/8nmtuE=;
        b=Dg5AaW+cXOG3UCb117mUsmYWky0JYfwjukmhT5YrjX0uSYZufp9ySioGC6uY/T2kFb
         DpFVJGLVdmi06uE8stG2Ld/0ga5sLnuqZCErQAXV2UMz4EX59Au2kG1kY+OURt02g3V5
         Dek6VhkxEUsIsQFMXMVZ+Ae1ee5PUoq23nqvDKc/0xaY3LVDtHV30QzfctbT+BiVVrJx
         ua9/l6ZshDdrYI5msQrOyhR9hR/v+vzBIW1rSKIO/yGC6kkzjMc7W59F9SnM3utVpkcD
         QV4j61mq0upYvBhGfDGjeclKE5nMQWMyytTTZCzlqSmX+sW7hFUhR5xnWWU5FtJGwWd4
         79nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790090790; x=1790695590;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/8zY26QjQrdL1DZs1bTzu+yz0u+JYpgALxi7/8nmtuE=;
        b=BuVy3CO2jCe971/f9e0q8AQVrxh8mqZMejlRXWuGzOrZEj67sm70lmQyxrMSBzvGEt
         NhJLeF8zwP7I/RVPli0Rfiln2unazNzX87XZX9QBDdT1qLW/I8wN3YVERD+lGJBr3syG
         xkJpyhtzZTyapaefy4HWs62a4CcFV2vMlNshVTxNTBMTGhacgB4VwTaM3JpkT4Zf1DEa
         BcyWYVXp5TNcVNt+3bBxUqb8zPHXQJeyALtRMqH9urBnmD+g67mGG/QYbJtlxzsLS8lZ
         +P1HeZ1CsMGcYMG9JetIXWqlzsRegCHKsYg/ew/sWWOns8NoGg6TqqlSmwwPl1lm2Sj8
         RRdQ==
X-Gm-Message-State: AFuF++k5soDzuDL10EIF43nY2jxzOOKGrBz89VO12lREgzFFj5KkY98E
	60ctN655zJ4AJM7KPsnQoqGaGsHMKJzepcWmprXZxT8OX5C+2MP3lUIVPPYrjS1T6NuVM9LXV8a
	URjihx2TijgkM1zin3izDf8SawZP1z/jC99cZw+FXD7GNF9Fz+K1lPDMfjQ==
X-Gm-Gg: AYBFou1zJO8iCgfyjRFGopd0h/xAg+t3AQDXMwJ9VSe9b4NX55p8HvOYYWKUq+PonS3
	QqrSDRlY96NTi98olSQHrKD0RVA536sa2PK9nw60Tti8rtgeGpZsu4bfIeb7fRESWv96qseqNsq
	NYxKzYe+xmwz5hFZyCbk4Wsr2VxcoxXrZ6pQHVNDScN+udLZpwHDyDhSAYsNbZ+Gc/5dyJS3kr4
	7ETqquEpUkbMzOZlomkKS3eJ/ZR8GdyEKZI0Lai2dzfQrQaLAyFzA8/IwBZsqyIxRZUx+PgX1yG
	j/X7DFNAQScUp8+WA2//fV/btbLA0nIgfMku6n2E1hJsgfmMPUU93jxSn+gS//BimsEUq3aY9zm
	BBpffrc5BT2z78dyCjuD62BW9I8sERsypP4MfHw4=
X-Received: by 2002:a05:600d:16:b0:49f:c1a1:5222 with SMTP id 5b1f17b1804b1-49fcbb0de51mr143310045e9.33.1790090790095;
        Tue, 22 Sep 2026 08:26:30 -0700 (PDT)
X-Received: by 2002:a05:600d:16:b0:49f:c1a1:5222 with SMTP id 5b1f17b1804b1-49fcbb0de51mr143309765e9.33.1790090789634;
        Tue, 22 Sep 2026 08:26:29 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde00473dsm3653365e9.0.2026.09.22.08.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:26:29 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Pablo Neira Ayuso <pablo@netfilter.org>,
  Florian Westphal <fw@strlen.de>,  Phil Sutter <phil@nwl.cc>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Eelco Chaudron <echaudro@redhat.com>,  Jamal
 Hadi Salim <jhs@mojatatu.com>,  Jiri Pirko <jiri@resnulli.us>,  Xin Long
 <lucien.xin@gmail.com>,  Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>,  netfilter-devel@vger.kernel.org,
  coreteam@netfilter.org,  linux-kernel@vger.kernel.org,
  dev@openvswitch.org,  stable@vger.kernel.org,  Axel Mierczuk
 <axel.mierczuk@1password.com>
Subject: Re: [PATCH net 1/6] net: openvswitch: conntrack: avoid modifying
 shared unconfirmed ct entry
In-Reply-To: <20260921145655.3167436-2-i.maximets@ovn.org> (Ilya Maximets's
	message of "Mon, 21 Sep 2026 16:55:43 +0200")
References: <20260921145655.3167436-1-i.maximets@ovn.org>
	<20260921145655.3167436-2-i.maximets@ovn.org>
Date: Tue, 22 Sep 2026 11:26:25 -0400
Message-ID: <f7tecelb93y.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ilya Maximets <i.maximets@ovn.org> writes:

> In a case where skb with an unconfirmed ct entry gets cloned, we may
> end up committing both but with different sets of extensions.
>
> The series of events:
>
>  1. The first clone wants to commit and runs the helpers wiring up
>     the extension pointer into the expectation list.
>  2. Then it looses the confirmation keeping the entry unconfirmed.
>  3. Second clone now wants to commit labels and adds the new extension
>     for that breaking the pointer in the expectation list causing
>     UAF on the destruction path later.
>
> While this is possible to trigger, there should be no practical
> network pipeline where committing both clones without modifications
> into the same zone is needed.  So, let's just reset the entry in case
> for some reason we got an skb with a shared one during commit.  This
> doesn't affect any known use cases, but avoids any potential problems
> with sharing and modification of the unconfirmed ct entry.
>
> The fixes tag points to the introduction of helpers, since that's the
> main UAF trigger for the sharing.
>
> Fixes: cae3a2627520 ("openvswitch: Allow attaching helpers to ct action")
> Cc: stable@vger.kernel.org
> Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

