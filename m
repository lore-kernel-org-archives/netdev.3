Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEFD3D300D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884280; cv=none; b=hyObNliPJl5t/Y8pdlTc6n2qN58xISffrz6ki9Y3bi9s618xy2NtA5GD+gTC1WJCZV4Ps7tt+L9hGgtBs9nf3iXoxDKwRDJHAOJ4bWZOks9wuKAJxgEHvgkkamwx6LSor1lcqng+WU+7TW24W/t8FWM/xuel/oGteDnb7ReSK7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884280; c=relaxed/simple;
	bh=C9H9s7mvg2GyIEaSju90hsOvalVLyiGORrpF1j1XkLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGDZb1iSIEZpjYFnYEx3R9V328DUvY9dkQazK3YiKIQeEQIaPs652/37tZgCwhapcaMrpW6BP4kSELRRPXxTXKRy+RN/cIJYCCyFxjxp2VsgDcsqSEkQOk+0bPTCfbkRz6b3qky+892gcjgQq8R+z8AUldMM0fGNoVhZHZ/UxQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6AZZy0Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6AZZy0Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791884277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAXrXREiprfLoEX/e6C9z8QGRXjzRieF3sKdnNbTNyU=;
	b=b6AZZy0QnWMQ7/me6r4Ye9toLyzq58QSu+Rcie0uRUPoRPiZ6eOtZ6U6Xte51GPHS9xy01
	72xHcYq1JmT7qoht9FKcLjE6wKwcgRYOOWytB4wg95PNx1qqtMzOpLfPHaDvK2azV/XSrj
	koMwUUvSKGxoM5npvC4wy+4+vEpGsbQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-_2TsnjqXNyun_4muTycS5A-1; Tue,
 13 Oct 2026 09:37:51 +0000
X-MC-Unique: _2TsnjqXNyun_4muTycS5A-1
X-Mimecast-MFC-AGG-ID: _2TsnjqXNyun_4muTycS5A_1791884269
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CF5A1956096;
	Tue, 13 Oct 2026 09:37:49 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31B831956041;
	Tue, 13 Oct 2026 09:37:45 +0000 (UTC)
Message-ID: <37e2a938-9ab1-4fa3-b67d-6286ae8cc2ec@redhat.com>
Date: Tue, 13 Oct 2026 11:37:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 06/12] dpll: sit9531x: implement input pin
 state on a DPLL
To: Ali Rouhi <arouhi@sitime.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
 Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261009183151.78497-1-arouhi@sitime.com>
 <20261009183151.78497-7-arouhi@sitime.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261009183151.78497-7-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/9/26 20:31, Ali Rouhi wrote:
> From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> 
> Report and set whether an input takes part in a PLL's reference
> selection.  The device selects its reference itself from a priority
> table, so membership of that table is what the state means here: an input
> in the table is selectable, one absent from it is disconnected.  Setting
> the state adds the input to the table or removes it, and membership is
> read back from the device rather than remembered.  CONNECTED would ask
> for this input and no other, which the device cannot be told to do, so it
> is refused.  A physical input's receiver is shared by the four PLLs and is
> powered down only when the last of them lets go of it.
> 
> What the device does with an input is its operational state.  The pin
> reported active is the one the device says it feeds the PLL, read from
> the PLL's debug status bus, while the PLL is locked to it -- outer loop
> running, not frozen -- and its lane has signal.  It is not the active
> selection: that names the source the driver asked for, and when that
> source loses its signal the device falls back to another listed source
> on its own and leaves the selection naming the dead one, so after such a
> failover the pin the PLL moved to reports active and the one it left
> does not.  The status bus names what is fed to the PLL, not what the PLL
> is locked to, so the lane's monitor has to agree.  It is read only while
> the PLL tracks a reference, six transfers per such PLL per tick; in
> free-run the PLL is fed nothing.  The poll reads every lane's clock
> monitor: an input whose monitor reports loss of signal is no-signal, one
> that reports a frequency drift is qual-failed, any other is standby.
> 
> The table is built from a priority the driver keeps per source and PLL,
> seeded from the table the device loaded: members in priority order, the
> slots past the last one naming no source.  The four-bit slot encoding
> has two codes for a fifth input pair this part does not have, and one of
> them serves as that.  A disconnected input keeps its priority for when it
> comes back, and a table that would come out as the device already holds
> it is not written.
> 
> The last register of the table also carries the device's active
> selection.  After a table write the PLL goes to the source it names, and
> leaves it on its own only when that source loses its signal, so every
> write names a source the PLL can use.  When the priorities put a
> different source with signal first, the selection goes to it -- the
> highest-priority valid input, which is how the DPLL interface defines
> automatic mode.  A write that only changes the table below that source
> leaves the selection where it is while it is still listed and has
> signal, so an edit there does not pull a PLL off a healthy reference;
> failing that, it goes to the first listed source that has signal.
> 
> Removing the last input is allowed.  The selection then has nothing to
> name, and left as it is it would keep the PLL following its old source
> for as long as that has signal, so the PLL stays in the forced holdover
> the write sequence uses -- the one state in which it follows no input.
> The next write that lists a source releases it.  A holdover the driver
> did not force -- set by the loaded configuration or by a tool -- is left
> in place by such a write; only the hold the driver itself set for an
> empty table is released.
> 
> The pins fall into three roles and only the first answers this question,
> so the contract for all of them is written above the operations rather
> than left to be inferred: inputs and the inter-PLL sync destination take
> part in selection; an output and the sync source are driven by the PLL and
> report whether they carry a signal; the crystal is fixed and always
> connected, since a PLL cannot be told to stop using it.
> 
> Probe also warns about a firmware pin node whose reg names no pin the
> device can have -- a lane or an output the variant lacks, or the N lane
> of a pair the configuration runs differential -- since nodes are looked
> up from the pins and such a node would otherwise be dropped silently.
> 
> Rewriting the table means forcing the PLL into holdover, waiting for it to
> take, writing every slot and releasing holdover again, all under the
> device lock -- ten to twenty milliseconds.  The device has no way to
> change one slot in isolation, and holdover is what keeps the loop from
> chasing a table that is momentarily inconsistent, so the sequence is the
> cost of doing it correctly.  Its error paths leave the device where the
> request found it: a failed write is rolled back through the register
> that failed, a force that failed is released all the same since the
> write may have landed, the hold stays when the table the device holds
> afterwards lists no source, and the selection is never picked from a
> monitor read that failed.  A release that fails after the table was
> written and latched is owed, and the poll retries it until it lands.
> A hold with no source listed and no valid holdover memory reports the
> PLL unlocked, as the interface asks, rather than in holdover.
> 
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: LLM
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>   drivers/dpll/sit9531x/core.c | 1145 ++++++++++++++++++++++++++++++++--
>   drivers/dpll/sit9531x/core.h |   42 +-
>   drivers/dpll/sit9531x/dpll.c |  320 +++++++++-
>   drivers/dpll/sit9531x/regs.h |   41 ++
>   4 files changed, 1483 insertions(+), 65 deletions(-)
> 
Reviewed-by: Ivan Vecera <ivecera@redhat.com>

