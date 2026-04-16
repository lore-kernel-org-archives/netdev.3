Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633A37A4B9
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776336135; cv=none; b=V6SEdEpT/NbAQmi1GDD91Ubvk2366NEwbbpM3Xqa0mjQljgxNcFNydJoaGwrXuXcHNZ0OUqVASRq0LXl+NzcHCwF37XWPhkdmqFRSE0cAggZltjlgiVQ9KgACscFGi7l1NVlCTSvDv1AK8lN3SPeSLvTGe+ziZjmCaeLy9Z/J2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776336135; c=relaxed/simple;
	bh=4KCAwX2ffmP9QmsA4dOpJNUJWAVPZMY/xrX0CWCKmAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOgAjWM6k7L7cG0t214vSytjc+TNUZW/g425UPNFrgADRTg1OzUCc9mddzycuVUitFlsyrgYThXyB02c8hNrpf2mrEuzETvU6zd59yekAZAU+3mGTpU9EbGOrbfzn7TrHmRh33tQFNw1OzweFPjGRGqGwirHyxeLGcHDoitvlOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GSPL9eLt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSPL9eLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776336133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YcHRMn2MX9rE+OcZPrjtF6d4B4T1aBhGiFRSbBkCQVE=;
	b=GSPL9eLt2ZlEdFRa0hKgogDiRP0xMVE0oFVbkzvPTyC3lJ8Dvoayt/21T0Hcz3eyOe+ABn
	tk2OR6jvX3FhGkw/YvSHG166o5LrEvsreQNSevGl8tbJE1qzGVRR+M5uwkWOy05O53UKyQ
	qZvFlq7SulO2r7ecmFUkw20A0Og5NK8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642--14bVJQ7OcKPn3bjhwmcBw-1; Thu,
 16 Apr 2026 06:42:11 -0400
X-MC-Unique: -14bVJQ7OcKPn3bjhwmcBw-1
X-Mimecast-MFC-AGG-ID: -14bVJQ7OcKPn3bjhwmcBw_1776336130
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F8CF1955F0E;
	Thu, 16 Apr 2026 10:42:10 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.44.32.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05B1A19560B6;
	Thu, 16 Apr 2026 10:42:10 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 70801A80D59; Thu, 16 Apr 2026 12:42:07 +0200 (CEST)
Date: Thu, 16 Apr 2026 12:42:07 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Corinna Vinschen <vinschen@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net] ixgbe: only access vfinfo and
 mv_list under RCU lock
Message-ID: <aeC8_9rAGqj915-8@calimero.vinschen.de>
Mail-Followup-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260416084227.3787828-1-vinschen@redhat.com>
 <IA3PR11MB898633AB0B2D010F495944E8E5232@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA3PR11MB898633AB0B2D010F495944E8E5232@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Apr 16 09:23, Loktionov, Aleksandr wrote:
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > [...]
> > @@ -9744,17 +9781,23 @@ static int ixgbe_ndo_get_vf_stats(struct
> > net_device *netdev, int vf,
> >  				  struct ifla_vf_stats *vf_stats)
> >  {
> >  	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
> > +	struct vf_data_storage *vfinfo;
> > 
> >  	if (vf < 0 || vf >= adapter->num_vfs)
> >  		return -EINVAL;
> > 
> > -	vf_stats->rx_packets = adapter->vfinfo[vf].vfstats.gprc;
> > -	vf_stats->rx_bytes   = adapter->vfinfo[vf].vfstats.gorc;
> > -	vf_stats->tx_packets = adapter->vfinfo[vf].vfstats.gptc;
> > -	vf_stats->tx_bytes   = adapter->vfinfo[vf].vfstats.gotc;
> > -	vf_stats->multicast  = adapter->vfinfo[vf].vfstats.mprc;
> > +	rcu_read_lock();
> > +	vfinfo = rcu_dereference(adapter->vfinfo);
> > +	if (vfinfo) {
> > +		vf_stats->rx_packets = vfinfo[vf].vfstats.gprc;
> > +		vf_stats->rx_bytes   = vfinfo[vf].vfstats.gorc;
> > +		vf_stats->tx_packets = vfinfo[vf].vfstats.gptc;
> > +		vf_stats->tx_bytes   = vfinfo[vf].vfstats.gotc;
> > +		vf_stats->multicast  = vfinfo[vf].vfstats.mprc;
> > +	}
> > +	rcu_read_unlock();
> > 
> > -	return 0;
> > +	return vfinfo ? 0 : -EINVAL;
> Before it returned always success, but now it will break 'ip link show dev' in short window when SR-IOV is being torn down.
> For me it looks like UAPI regression.

Good point.  I'll change that back for a v2, just waiting for more
feedback.


Thanks,
Corinna

